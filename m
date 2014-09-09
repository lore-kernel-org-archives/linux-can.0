From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Inconsistent error state transition error frames
Date: Tue, 09 Sep 2014 20:08:37 +0200
Message-ID: <540F4225.4090907@hartkopp.net>
References: <7EAA3DE6DC6BA14D830C95541CC66EBC9F72FED6@GRBSR0004.marel.net> <540DDB16.8010304@pengutronix.de> <a62de8d447dda55b1aa30711f0dc4605@grandegger.com> <540EEBA0.9080209@marel.com> <56f33e0559ffda649925492dca2720fd@grandegger.com> <540F1396.2030702@marel.com> <1a51435a44c2ebd32cca3feee3799af3@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.216]:26003 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751665AbaIISI4 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 9 Sep 2014 14:08:56 -0400
In-Reply-To: <1a51435a44c2ebd32cca3feee3799af3@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>, Andri Yngvason <andri.yngvason@marel.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org



On 09.09.2014 17:41, Wolfgang Grandegger wrote:
> On Tue, 9 Sep 2014 14:49:58 +0000, Andri Yngvason
> <andri.yngvason@marel.com> wrote:


>> It seems that 'data' is fully occupied, although 'data[5..7]' isn't 
>> reserved for anything specific but rather "controller specific 
>> additional information". Could we maybe put the version into data 5, 6
> or
>> 7?
> 
> data[6..7] is used for the tx and rx error counts.
>  

Oh yes. This is currently not documented in error.h :-(

What about adding some defines for it, like this:

diff --git a/include/uapi/linux/can/error.h b/include/uapi/linux/can/error.h
index c247446..c290f30 100644
--- a/include/uapi/linux/can/error.h
+++ b/include/uapi/linux/can/error.h
@@ -58,10 +58,12 @@
 #define CAN_ERR_RESTARTED    0x00000100U /* controller restarted */
 
 /* arbitration lost in bit ... / data[0] */
+#define CAN_ERR_LOSTARB_BYTE 0
 #define CAN_ERR_LOSTARB_UNSPEC   0x00 /* unspecified */
 				      /* else bit number in bitstream */
 
 /* error status of CAN-controller / data[1] */
+#define CAN_ERR_CRTL_BYTE 1
 #define CAN_ERR_CRTL_UNSPEC      0x00 /* unspecified */
 #define CAN_ERR_CRTL_RX_OVERFLOW 0x01 /* RX buffer overflow */
 #define CAN_ERR_CRTL_TX_OVERFLOW 0x02 /* TX buffer overflow */
@@ -73,6 +75,7 @@
 				      /* the protocol-defined level of 127)  */
 
 /* error in CAN protocol (type) / data[2] */
+#define CAN_ERR_PROT_BYTE 2
 #define CAN_ERR_PROT_UNSPEC      0x00 /* unspecified */
 #define CAN_ERR_PROT_BIT         0x01 /* single bit error */
 #define CAN_ERR_PROT_FORM        0x02 /* frame format error */
@@ -84,6 +87,7 @@
 #define CAN_ERR_PROT_TX          0x80 /* error occurred on transmission */
 
 /* error in CAN protocol (location) / data[3] */
+#define CAN_ERR_PROT_LOC_BYTE 3
 #define CAN_ERR_PROT_LOC_UNSPEC  0x00 /* unspecified */
 #define CAN_ERR_PROT_LOC_SOF     0x03 /* start of frame */
 #define CAN_ERR_PROT_LOC_ID28_21 0x02 /* ID bits 28 - 21 (SFF: 10 - 3) */
@@ -106,6 +110,7 @@
 #define CAN_ERR_PROT_LOC_INTERM  0x12 /* intermission */
 
 /* error status of CAN-transceiver / data[4] */
+#define CAN_ERR_TRX_BYTE 4
 /*                                             CANH CANL */
 #define CAN_ERR_TRX_UNSPEC             0x00 /* 0000 0000 */
 #define CAN_ERR_TRX_CANH_NO_WIRE       0x04 /* 0000 0100 */
@@ -118,6 +123,10 @@
 #define CAN_ERR_TRX_CANL_SHORT_TO_GND  0x70 /* 0111 0000 */
 #define CAN_ERR_TRX_CANL_SHORT_TO_CANH 0x80 /* 1000 0000 */
 
-/* controller specific additional information / data[5..7] */
+/* controller specific additional information / data[5] */
+
+/* controller error counter values / data[6..7] */
+#define CAN_ERR_TXERR_BYTE 6
+#define CAN_ERR_RXERR_BYTE 7
 
 #endif /* _UAPI_CAN_ERROR_H */


>> Another option is to place it into the 3 or 4 msb of the id; something 
>> like this:
>> #define CAN_ERR_VERSION_MASK 0x1E000000U  // Note: CAN_ERR_MASK is 
>> 0x1FFFFFFFU
>>
>> Are 15 possible versions enough (or even too much)?
> 
> I would prefer an unsued field otherwise old can-util tools will report
> rubbish. data[5] sounds good. But we should add a version number only
> if we really need it.

Yes.

As the current situation needs a re-work and is somehow broken I wonder if
the current implementation is really used widely by that many people ?!?

As you introduce a new bit we should check if there is really that much
fallout that a version info becomes necessary.

Maybe be we can change the definition and only update the can-utils accordingly.

Or do you see any general problem for the suggested changes?

Regards,
Oliver

