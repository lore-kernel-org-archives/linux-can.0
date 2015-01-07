From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: iproute2 fd-non-iso PoC - was Re: [PATCH v4] can/peak_usb: add support
 for PEAK new CANFD USB adapters
Date: Wed, 07 Jan 2015 19:37:58 +0100
Message-ID: <54AD7D06.5030705@hartkopp.net>
References: <1420538446-8336-1-git-send-email-s.grosjean@peak-system.com> <54AD66C5.10908@pengutronix.de> <54AD6ED8.2020808@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060800090806000106000909"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.220]:41853 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753386AbbAGSiP (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 7 Jan 2015 13:38:15 -0500
In-Reply-To: <54AD6ED8.2020808@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Stephane Grosjean <s.grosjean@peak-system.com>, linux-can@vger.kernel.org

This is a multi-part message in MIME format.
--------------060800090806000106000909
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Just a short test:

I added u32 ctrlmode in Stephanes peak_usb_adapter struct for a test:

@@ -44,8 +46,11 @@ struct peak_usb_device;
 struct peak_usb_adapter {
        char *name;
        u32 device_id;
+       u32 ctrlmode_supported;
+       u32 ctrlmode;
        struct can_clock clock;

Which looks like this in pcan_usb_pro.c

@@ -1015,6 +1007,8 @@ struct peak_usb_adapter pcan_usb_pro = {
        .name = "PCAN-USB Pro",
        .device_id = PCAN_USBPRO_PRODUCT_ID,
        .ctrl_count = PCAN_USBPRO_CHANNEL_COUNT,
+       .ctrlmode = 0,
+       .ctrlmode_supported = CAN_CTRLMODE_3_SAMPLES | CAN_CTRLMODE_LISTENONLY,
        .clock = {

and in pcan_usb_fd.c :

/* describes the PCAN-USB Pro FD adapter */
struct peak_usb_adapter pcan_usb_pro_fd = {
        .name = "PCAN-USB Pro FD",
        .device_id = PCAN_USBPROFD_PRODUCT_ID,
        .ctrl_count = PCAN_USBPROFD_CHANNEL_COUNT,
        .ctrlmode = CAN_CTRLMODE_FD_NON_ISO,
        .ctrlmode_supported = CAN_CTRLMODE_FD |
                        CAN_CTRLMODE_3_SAMPLES | CAN_CTRLMODE_LISTENONLY,
        .clock = {

Finally the ip tools gives this output (when FD is enabled):

# ip -det link show can0
17: can0: <NOARP,ECHO> mtu 72 qdisc noop state DOWN mode DEFAULT group default qlen 10
    link/can  promiscuity 0 
    can <FD,FD-NON-ISO> state STOPPED restart-ms 0 
	  pcan_usb_fd: tseg1 1..64 tseg2 1..16 sjw 1..16 brp 1..1024 brp-inc 1
	  pcan_usb_fd: dtseg1 1..16 dtseg2 1..8 dsjw 1..4 dbrp 1..1024 dbrp-inc 1
	  clock 80000000

AND - as expected - removing this flag is denied:

# ip link set dev can0 type can fd-non-iso off
RTNETLINK answers: Operation not supported

Regards,
Oliver

ps. Current patch for iproute2 is attached. Will send a proper patch when
CAN_CTRLMODE_FD_NON_ISO found its way into mainline.



--------------060800090806000106000909
Content-Type: text/x-patch;
 name="iproute2-fd-non-iso.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="iproute2-fd-non-iso.patch"

diff --git a/include/linux/can/netlink.h b/include/linux/can/netlink.h
index 25fd52c..6d4ec2a 100644
--- a/include/linux/can/netlink.h
+++ b/include/linux/can/netlink.h
@@ -98,6 +98,7 @@ struct can_ctrlmode {
 #define CAN_CTRLMODE_BERR_REPORTING	0x10	/* Bus-error reporting */
 #define CAN_CTRLMODE_FD			0x20	/* CAN FD mode */
 #define CAN_CTRLMODE_PRESUME_ACK	0x40	/* Ignore missing CAN ACKs */
+#define CAN_CTRLMODE_FD_NON_ISO		0x80	/* CAN FD in non-ISO mode */
 
 /*
  * CAN device statistics
diff --git a/ip/iplink_can.c b/ip/iplink_can.c
index fb50332..f1b089d 100644
--- a/ip/iplink_can.c
+++ b/ip/iplink_can.c
@@ -37,6 +37,7 @@ static void print_usage(FILE *f)
 		"\t[ one-shot { on | off } ]\n"
 		"\t[ berr-reporting { on | off } ]\n"
 		"\t[ fd { on | off } ]\n"
+		"\t[ fd-non-iso { on | off } ]\n"
 		"\t[ presume-ack { on | off } ]\n"
 		"\n"
 		"\t[ restart-ms TIME-MS ]\n"
@@ -100,6 +101,7 @@ static void print_ctrlmode(FILE *f, __u32 cm)
 	_PF(CAN_CTRLMODE_ONE_SHOT, "ONE-SHOT");
 	_PF(CAN_CTRLMODE_BERR_REPORTING, "BERR-REPORTING");
 	_PF(CAN_CTRLMODE_FD, "FD");
+	_PF(CAN_CTRLMODE_FD_NON_ISO, "FD-NON-ISO");
 	_PF(CAN_CTRLMODE_PRESUME_ACK, "PRESUME-ACK");
 #undef _PF
 	if (cm)
@@ -203,6 +205,10 @@ static int can_parse_opt(struct link_util *lu, int argc, char **argv,
 			NEXT_ARG();
 			set_ctrlmode("fd", *argv, &cm,
 				     CAN_CTRLMODE_FD);
+		} else if (matches(*argv, "fd-non-iso") == 0) {
+			NEXT_ARG();
+			set_ctrlmode("fd-non-iso", *argv, &cm,
+				     CAN_CTRLMODE_FD_NON_ISO);
 		} else if (matches(*argv, "presume-ack") == 0) {
 			NEXT_ARG();
 			set_ctrlmode("presume-ack", *argv, &cm,

--------------060800090806000106000909--
