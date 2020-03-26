import * as functions from 'firebase-functions';
import * as admin from "firebase-admin";
import Utils from "./util/cf-helper-methods";

const db = admin.firestore();
const USER_RESPONSE_COLLECTION_PATH = 'corona-user-responses';
//const COVIDARC_COLLECTION_PATH = 'COVIDARC';
//const COVIDARC_COLLECTION_REF = db.collection(COVIDARC_COLLECTION_PATH);
const USER_RESPONSE_COLLECTION_PATH_REF = db.collection(USER_RESPONSE_COLLECTION_PATH);
const ORGANIZATION_COLLECTION_PATH = 'organisations';
const ORGANIZATION_COLLECTION_REF = db.collection(ORGANIZATION_COLLECTION_PATH);

/**
 * Details: https://docs.google.com/spreadsheets/d/13x-6koKiqRnIK6_trJX-abLJyi65OzqV621u9iwM1qw/edit#gid=2008915096
 * Note: tslint:disable-next-line:radix
 * Warning: User response data type not defined right now.
 */

export const onUserResponseSubmit = functions.https.onCall(async (userResponse) => {
	const elderAge = 60;
	try {
		//const organisationFromReq = userResponse['organization_name'];
		const organisationIDFromReq = userResponse['organization_id'];

		const organisationFromDB = await ORGANIZATION_COLLECTION_REF.doc(organisationIDFromReq).get();

		if(!organisationFromDB.exists) userResponse['organization_name']='anonymous';

		//const response = await db.collection(USER_RESPONSE_COLLECTION_PATH).add(userResponse);

		const is_elder = parseInt(userResponse['age']['answer']) > elderAge ? '1' : '0';
		const has_diseases_history = userResponse['high_risk']['answer'].toString() === 'true' ? '1' : '0';
		const symptom_risk = getSymptomRisk(userResponse);
		const epidemic_risk = getEpidemicRisk(userResponse);
		const finalRiskAssessment = getFinalRiskAssessment(symptom_risk, is_elder, has_diseases_history, epidemic_risk);
		const assessmentMessage = getAssessmentMessage(finalRiskAssessment);

		userResponse['risk']=finalRiskAssessment;
		userResponse['created_at'] = Date.now();

		const riskData = await db.collection('corona-response-template').doc(finalRiskAssessment.toString()).get();
		const response = await db.collection(USER_RESPONSE_COLLECTION_PATH).add(userResponse);

		//const numbers: any[]=[];

		return {
			assessmentMessage,
			risk: finalRiskAssessment,
			uniqueId: response.id,
			instructions: riskData.get('message'),
			numbers:riskData.get('numbers')
		};

	} catch (error) {
		console.error("onUserResponseSubmit Error:", error);
		return error
	}
});

export const getResponsesByUserPhone = functions.https.onCall(async (userNum) => {
	try {
		console.log(userNum);
		if (!('number' in userNum)) return {
			error: "Invalid parameter"
		}
		const phoneNumber = userNum['number'];

		if (!Utils.isValidPhoneNumber(phoneNumber)) return {
			error: "Not Valid Phone, Example 01719114455"
		}

		const responses: any[] = [];
		const querySnap = await USER_RESPONSE_COLLECTION_PATH_REF.where('user_phone', '==', phoneNumber).get();
		if (querySnap.empty) return {
			error: "Phone Number Does Not Exist"
		}

		await Promise.all(querySnap.docs.map(async (doc) => {
			const data=doc.data();
			data['organization_id']='************';
			responses.push(data);
		}));

		return {
			responses
		};
	} catch (error) {
		console.error("getResponsesByUserPhone Error:", error);
		return error;
	}
});

export const getResponsesByOrgName = functions.https.onCall(async (orgName) => {
	try {
		if (!('organization_name' in orgName)) return {
			error: "Invalid parameter"
		}
		const orgnameS = orgName['organization_name'];

		const responses: any[] = [];
		const querySnap = await USER_RESPONSE_COLLECTION_PATH_REF.where('organization_name', '==', orgnameS).get();
		if (querySnap.empty) return {
			error: "Organization Does Not Exist"
		}

		await Promise.all(querySnap.docs.map(async (doc) => {
			const data=doc.data();
			data['organization_id']='************';
			responses.push(data);
		}));

		return {
			responses
		};
	} catch (error) {
		console.error("getResponsesByUserPhone Error:", error);
		return error;
	}
});

function getSymptomRisk(data: any): number {
	const is_feverish = data['is_feverish']['answer'].toString() === 'true' ? '1' : '0';
	const has_sore_throat = data['has_sore_throat']['answer'].toString() === 'true' ? '1' : '0';
	const has_breathlessness = data['has_breathlessness']['answer'].toString() === 'true' ? '1' : '0';

	if (`${is_feverish}${has_sore_throat}${has_breathlessness}` === `000`) return 0;
	if (`${is_feverish}${has_sore_throat}${has_breathlessness}` === `001`) return 2;
	if (`${is_feverish}${has_sore_throat}${has_breathlessness}` === `010`) return 1;
	if (`${is_feverish}${has_sore_throat}${has_breathlessness}` === `011`) return 2;
	if (`${is_feverish}${has_sore_throat}${has_breathlessness}` === `100`) return 1;
	if (`${is_feverish}${has_sore_throat}${has_breathlessness}` === `101`) return 2;
	if (`${is_feverish}${has_sore_throat}${has_breathlessness}` === `110`) return 1;
	if (`${is_feverish}${has_sore_throat}${has_breathlessness}` === `111`) return 2;

	return 0;
}

function getEpidemicRisk(data: any) {
	const is_visited_abroad = data['is_visited_abroad']['answer'].toString() === 'true' ? '1' : '0';
	const is_contacted_with_covid = data['is_contacted_with_covid']['answer'].toString() === 'true' ? '1' : '0';
	const is_contacted_with_family_who_cough = data['is_contacted_with_family_who_cough']['answer'].toString() === 'true' ? '1' : '0';

	if (`${is_visited_abroad}${is_contacted_with_covid}${is_contacted_with_family_who_cough}` === `000`) return 0;
	if (`${is_visited_abroad}${is_contacted_with_covid}${is_contacted_with_family_who_cough}` === `001`) return 1;
	if (`${is_visited_abroad}${is_contacted_with_covid}${is_contacted_with_family_who_cough}` === `010`) return 2;
	if (`${is_visited_abroad}${is_contacted_with_covid}${is_contacted_with_family_who_cough}` === `011`) return 2;
	if (`${is_visited_abroad}${is_contacted_with_covid}${is_contacted_with_family_who_cough}` === `100`) return 1;
	if (`${is_visited_abroad}${is_contacted_with_covid}${is_contacted_with_family_who_cough}` === `101`) return 2;
	if (`${is_visited_abroad}${is_contacted_with_covid}${is_contacted_with_family_who_cough}` === `110`) return 2;
	if (`${is_visited_abroad}${is_contacted_with_covid}${is_contacted_with_family_who_cough}` === `111`) return 2;

	return 0;
}

// tslint:disable-next-line:cyclomatic-complexity
function getFinalRiskAssessment(symptom_risk: any, is_elder: any, has_diseases_history: any, epidemic_risk: any): number {

	if (`${symptom_risk}${is_elder}${has_diseases_history}${epidemic_risk}` === `0000`) return 0;
	if (`${symptom_risk}${is_elder}${has_diseases_history}${epidemic_risk}` === `0001`) return 1;
	if (`${symptom_risk}${is_elder}${has_diseases_history}${epidemic_risk}` === `0002`) return 1;
	if (`${symptom_risk}${is_elder}${has_diseases_history}${epidemic_risk}` === `0010`) return 0;
	if (`${symptom_risk}${is_elder}${has_diseases_history}${epidemic_risk}` === `0011`) return 1;
	if (`${symptom_risk}${is_elder}${has_diseases_history}${epidemic_risk}` === `0012`) return 2;
	if (`${symptom_risk}${is_elder}${has_diseases_history}${epidemic_risk}` === `0100`) return 0;
	if (`${symptom_risk}${is_elder}${has_diseases_history}${epidemic_risk}` === `0101`) return 1;
	if (`${symptom_risk}${is_elder}${has_diseases_history}${epidemic_risk}` === `0102`) return 3;
	if (`${symptom_risk}${is_elder}${has_diseases_history}${epidemic_risk}` === `0110`) return 0;
	if (`${symptom_risk}${is_elder}${has_diseases_history}${epidemic_risk}` === `0111`) return 2;
	if (`${symptom_risk}${is_elder}${has_diseases_history}${epidemic_risk}` === `0112`) return 2;
	if (`${symptom_risk}${is_elder}${has_diseases_history}${epidemic_risk}` === `1000`) return 1;
	if (`${symptom_risk}${is_elder}${has_diseases_history}${epidemic_risk}` === `1001`) return 1;
	if (`${symptom_risk}${is_elder}${has_diseases_history}${epidemic_risk}` === `1002`) return 4;
	if (`${symptom_risk}${is_elder}${has_diseases_history}${epidemic_risk}` === `1010`) return 1;
	if (`${symptom_risk}${is_elder}${has_diseases_history}${epidemic_risk}` === `1011`) return 2;
	if (`${symptom_risk}${is_elder}${has_diseases_history}${epidemic_risk}` === `1012`) return 4;
	if (`${symptom_risk}${is_elder}${has_diseases_history}${epidemic_risk}` === `1100`) return 1;
	if (`${symptom_risk}${is_elder}${has_diseases_history}${epidemic_risk}` === `1101`) return 4;
	if (`${symptom_risk}${is_elder}${has_diseases_history}${epidemic_risk}` === `1102`) return 4;
	if (`${symptom_risk}${is_elder}${has_diseases_history}${epidemic_risk}` === `1110`) return 1;
	if (`${symptom_risk}${is_elder}${has_diseases_history}${epidemic_risk}` === `1111`) return 4;
	if (`${symptom_risk}${is_elder}${has_diseases_history}${epidemic_risk}` === `1112`) return 4;
	if (`${symptom_risk}${is_elder}${has_diseases_history}${epidemic_risk}` === `2000`) return 5;
	if (`${symptom_risk}${is_elder}${has_diseases_history}${epidemic_risk}` === `2001`) return 5;
	if (`${symptom_risk}${is_elder}${has_diseases_history}${epidemic_risk}` === `2002`) return 6;
	if (`${symptom_risk}${is_elder}${has_diseases_history}${epidemic_risk}` === `2010`) return 5;
	if (`${symptom_risk}${is_elder}${has_diseases_history}${epidemic_risk}` === `2011`) return 5;
	if (`${symptom_risk}${is_elder}${has_diseases_history}${epidemic_risk}` === `2012`) return 6;
	if (`${symptom_risk}${is_elder}${has_diseases_history}${epidemic_risk}` === `2100`) return 5;
	if (`${symptom_risk}${is_elder}${has_diseases_history}${epidemic_risk}` === `2101`) return 5;
	if (`${symptom_risk}${is_elder}${has_diseases_history}${epidemic_risk}` === `2102`) return 6;
	if (`${symptom_risk}${is_elder}${has_diseases_history}${epidemic_risk}` === `2110`) return 5;
	if (`${symptom_risk}${is_elder}${has_diseases_history}${epidemic_risk}` === `2111`) return 5;
	if (`${symptom_risk}${is_elder}${has_diseases_history}${epidemic_risk}` === `2112`) return 6;

	return 0;
}

function getAssessmentMessage(risk: number) {
	if (`${risk}` === `0`) return 'Safe';
	if (`${risk}` === `1`) return 'Stay Home/Quarantine';
	if (`${risk}` === `2`) return 'Mandatory Quarantine/Followup';
	if (`${risk}` === `3`) return 'Request Test';
	if (`${risk}` === `4`) return 'Urgent/Contact with Covid Facility';
	if (`${risk}` === `5`) return 'Extra Urgent';
	if (`${risk}` === `6`) return 'VIP';

	return ''
}
