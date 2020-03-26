export default class Utils {

    static hasValue(val: any): boolean {
        return !(val === null || val === false || val === '');
    }

    static isValidPhoneNumber(phone: string): boolean {
        return !!phone.match('^([0-9]{11})$');
    }
}
