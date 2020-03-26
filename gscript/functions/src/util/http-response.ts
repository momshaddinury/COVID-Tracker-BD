import { HttpStatusCode } from "./http-status-code";

export interface HttpResponseType {
    data?: any;
    statusCode: number;
    message: string;
}

export const DEFAULT_HTTP_RESPONSE: HttpResponseType = {
    data: null,
    statusCode: HttpStatusCode.NOT_IMPLEMENTED,
    message: ''
};

export function sendResponse(data: any, message: string, statusCode: number) {
    const response: HttpResponseType = DEFAULT_HTTP_RESPONSE;

    response.data = data;
    response.message = message;
    response.statusCode = statusCode;

    return response;
}
