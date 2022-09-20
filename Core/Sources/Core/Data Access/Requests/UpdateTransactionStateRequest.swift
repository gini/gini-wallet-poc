//
//  File.swift
//  
//
//  Created by Noemi Kalman on 18.09.2022.
//

import Foundation
import Alamofire

struct UpdateTransactionStateRequest: Request {
    var body: String?
    
    let path: String?
    let method: HTTPMethod
    
    var xmlBodyForPositive: String {
        return """

        <Document xmlns="urn:iso:std:iso:20022:tech:xsd:pain.014.001.07">
          <CdtrPmtActvtnReqStsRpt>
            <GrpHdr>
              <!-- unique id -->
              <MsgId>uniqueId456</MsgId>
              <!-- Creation Date Time-->
              <CreDtTm>2020-05-27T13:02:16.98</CreDtTm>
              <InitgPty/>
            </GrpHdr>
            <OrgnlGrpInfAndSts>
              <!-- refers to MsgId in DS-01 -->
              <OrgnlMsgId>uniqueId123</OrgnlMsgId>
              <!-- hardcoded -->
              <OrgnlMsgNmId>pain.013.001.07</OrgnlMsgNmId>
              <OrgnlCreDtTm>1984-06-02T11:06:43.09</OrgnlCreDtTm>
            </OrgnlGrpInfAndSts>
            <OrgnlPmtInfAndSts>
              <!-- refers to <PmtInfId> in DS-01  -->
              <OrgnlPmtInfId>1</OrgnlPmtInfId>
              <TxInfAndSts>
                <TxSts>\(accepted ? "ACCP" : "RJCT")</TxSts>
                <StsRsnInf>
                  <Orgtr>
                    <!-- AT-01 Payer identifier -->
                    <Id>
                      <PrvtId>
                        <Othr>
                          <!-- randomly generated string: max 35 chars. Refers to <CdtrPmtActvtnReq><PmtInf><Dbtr><Id> in DS-01 -->
                          <Id>eb2b65e0-16f2-11ed-8115-5d438a4d049</Id>
                          <SchmeNm>
                            <Prtry>OTID</Prtry>
                          </SchmeNm>
                        </Othr>
                      </PrvtId>
                    </Id>
                  </Orgtr>
                </StsRsnInf>
                <!-- todo -->
                <OrgnlInstrId>\(transactionId)</OrgnlInstrId>
                <!-- refers to <EndToEndId> in DS-01  -->
                <OrgnlEndToEndId>somestring</OrgnlEndToEndId>
                <!-- AT-R10 Payer’s response date/time -->
                <DbtrDcsnDtTm>2022-04-16T19:19:45.54</DbtrDcsnDtTm>
                <!-- AT-67 Payment date/time (as decided by the Payer) -->
                <AccptncDtTm>2022-01-07T20:42:56</AccptncDtTm>
                <OrgnlTxRef>
                  <Amt>
                    <!-- refers to InstdAmt in DS-01 -->
                    <InstdAmt Ccy="EUR">\(String(format: "%.2f", amount))</InstdAmt>
                  </Amt>
                  <!-- refers to ReqdExctnDt in DS-01 -->
                  <ReqdExctnDt>
                    <Dt>2019-10-11</Dt>
                  </ReqdExctnDt>
                  <!-- refers to XpryDt in DS-01 -->
                  <XpryDt>
                    <DtTm>2007-05-28T07:32:58.89</DtTm>
                  </XpryDt>
                  <!-- refers to PmtTpInf in DS-01 -->
                  <PmtTpInf>
                    <SvcLvl>
                      <!-- AT-40 Identification code of the Scheme. Hardcoded -->
                      <Cd>SEPA</Cd>
                    </SvcLvl>
                    <LclInstrm>
                      <!-- AT-65 Type of payment instrument requested by the Payee. -->
                      <!--TRF/INST/CRP/ITP. Hardcoded-->
                      <Cd>TRF</Cd>
                    </LclInstrm>
                  </PmtTpInf>
                  <!-- refers to DbtrAgt in DS-01 -->
                  <DbtrAgt>
                    <FinInstnId>
                      <Othr>
                        <Id>gini</Id>
                      </Othr>
                    </FinInstnId>
                  </DbtrAgt>
                  <!-- refers to CdtrAgt in DS-01 -->
                  <CdtrAgt>
                    <FinInstnId>
                      <Othr>
                        <!-- hardcoded -->
                        <Id>gini</Id>
                      </Othr>
                    </FinInstnId>
                  </CdtrAgt>
                  <Cdtr>
                    <!-- AT-21 name of the payee -->
                    <Nm>Rainbow Store</Nm>
                  </Cdtr>
                  <!-- refers to CdtrAcct in DS-01 -->
                  <CdtrAcct>
                    <Id>
                      <!-- Zalando's IBAN -->
                      <IBAN>DE86210700200123010101</IBAN>
                    </Id>
                  </CdtrAcct>
                </OrgnlTxRef>
              </TxInfAndSts>
            </OrgnlPmtInfAndSts>
          </CdtrPmtActvtnReqStsRpt>
        </Document>
        """
    }
    
    var xmlBodyForNegative: String {
        return """

        <Document xmlns="urn:iso:std:iso:20022:tech:xsd:pain.014.001.07">
          <CdtrPmtActvtnReqStsRpt>
            <GrpHdr>
              <!-- unique id -->
              <MsgId>uniqueId456</MsgId>
              <!-- Creation Date Time-->
              <CreDtTm>2020-05-27T13:02:16.98</CreDtTm>
              <InitgPty/>
            </GrpHdr>
            <OrgnlGrpInfAndSts>
              <!-- refers to MsgId in DS-01 -->
              <OrgnlMsgId>uniqueId123</OrgnlMsgId>
              <!-- hardcoded -->
              <OrgnlMsgNmId>pain.013.001.07</OrgnlMsgNmId>
              <OrgnlCreDtTm>1984-06-02T11:06:43.09</OrgnlCreDtTm>
            </OrgnlGrpInfAndSts>
            <OrgnlPmtInfAndSts>
              <!-- refers to <PmtInfId> in DS-01  -->
              <OrgnlPmtInfId>1</OrgnlPmtInfId>
              <TxInfAndSts>
                <TxSts>\(accepted ? "ACCP" : "RJCT")</TxSts>
                <StsRsnInf>
                  <Orgtr>
                    <!-- AT-01 Payer identifier -->
                    <Id>
                      <PrvtId>
                        <Othr>
                          <!-- randomly generated string: max 35 chars. Refers to <CdtrPmtActvtnReq><PmtInf><Dbtr><Id> in DS-01 -->
                          <Id>eb2b65e0-16f2-11ed-8115-5d438a4d049</Id>
                          <SchmeNm>
                            <Prtry>OTID</Prtry>
                          </SchmeNm>
                        </Othr>
                      </PrvtId>
                    </Id>
                  </Orgtr>
                </StsRsnInf>
                <!-- todo -->
                <OrgnlInstrId>\(transactionId)</OrgnlInstrId>
                <!-- refers to <EndToEndId> in DS-01  -->
                <OrgnlEndToEndId>somestring</OrgnlEndToEndId>
                <!-- AT-R10 Payer’s response date/time -->
                <DbtrDcsnDtTm>2022-04-16T19:19:45.54</DbtrDcsnDtTm>
                <!-- AT-67 Payment date/time (as decided by the Payer) -->
                <AccptncDtTm>2022-01-07T20:42:56</AccptncDtTm>
                <OrgnlTxRef>
                  <Amt>
                    <!-- refers to InstdAmt in DS-01 -->
                    <InstdAmt Ccy="EUR">\(String(format: "%.2f", amount))</InstdAmt>
                  </Amt>
                  <!-- refers to ReqdExctnDt in DS-01 -->
                  <ReqdExctnDt>
                    <Dt>2019-10-11</Dt>
                  </ReqdExctnDt>
                  <!-- refers to XpryDt in DS-01 -->
                  <XpryDt>
                    <DtTm>2007-05-28T07:32:58.89</DtTm>
                  </XpryDt>
                  <!-- refers to PmtTpInf in DS-01 -->
                  <PmtTpInf>
                    <SvcLvl>
                      <!-- AT-40 Identification code of the Scheme. Hardcoded -->
                      <Cd>SEPA</Cd>
                    </SvcLvl>
                    <LclInstrm>
                      <!-- AT-65 Type of payment instrument requested by the Payee. -->
                      <!--TRF/INST/CRP/ITP. Hardcoded-->
                      <Cd>TRF</Cd>
                    </LclInstrm>
                  </PmtTpInf>
                  <!-- refers to DbtrAgt in DS-01 -->
                  <DbtrAgt>
                    <FinInstnId>
                      <Othr>
                        <Id>gini</Id>
                      </Othr>
                    </FinInstnId>
                  </DbtrAgt>
                  <!-- refers to CdtrAgt in DS-01 -->
                  <CdtrAgt>
                    <FinInstnId>
                      <Othr>
                        <!-- hardcoded -->
                        <Id>gini</Id>
                      </Othr>
                    </FinInstnId>
                  </CdtrAgt>
                  <Cdtr>
                    <!-- AT-21 name of the payee -->
                    <Nm>Rainbow Store</Nm>
                  </Cdtr>
                  <!-- refers to CdtrAcct in DS-01 -->
                  <CdtrAcct>
                    <Id>
                      <!-- Zalando's IBAN -->
                      <IBAN>DE86210700200123010101</IBAN>
                    </Id>
                  </CdtrAcct>
                </OrgnlTxRef>
              </TxInfAndSts>
            </OrgnlPmtInfAndSts>
          </CdtrPmtActvtnReqStsRpt>
        </Document>
        """
    }
    
    private let transactionId: String
    private let iban: String
    private let amount: Double
    private let accepted: Bool
    
    init(transactionId: String, iban: String, amount: Double, accepted: Bool) {
        self.transactionId = transactionId
        self.iban = iban
        self.amount = amount
        self.accepted = accepted
        
        path = accepted ? APIConstants.Endpoints.Transactions.accept.path : APIConstants.Endpoints.Transactions.refuse.path
        method = .post
        body = accepted ? xmlBodyForPositive : xmlBodyForNegative
    }
}
