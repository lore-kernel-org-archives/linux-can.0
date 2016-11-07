From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Adding new CAN driver
Date: Mon, 7 Nov 2016 22:24:18 +0100
Message-ID: <e521bee5-d0e3-d894-2c0f-be2c437a2f48@hartkopp.net>
References: <CAKT-o-cOb0sqRmvH+BKjX4yvBLp5_GqVd6=ifr2jm5T75-hcZA@mail.gmail.com>
 <3113364.8FuUfmAlHQ@ws-stein>
 <SG2PR06MB1038F0416E850F0C09BC5CCEC3A00@SG2PR06MB1038.apcprd06.prod.outlook.com>
 <1490105.s3iJfGbYsS@ws-stein>
 <CAKT-o-cJ3UwD=xakh7-hF5101rS2zCa5AHfjBvdRNATJD+Weqw@mail.gmail.com>
 <5f302213-c072-b6b8-aa78-4bc405dc167d@hartkopp.net>
 <20161103212427.GA1677@airbook.vandijck-laurijssen.be>
 <SG2PR06MB10381FBE7242FA602F1AC319C3A20@SG2PR06MB1038.apcprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.163]:30806 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752242AbcKGVYh (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 7 Nov 2016 16:24:37 -0500
In-Reply-To: <SG2PR06MB10381FBE7242FA602F1AC319C3A20@SG2PR06MB1038.apcprd06.prod.outlook.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>, Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Cc: =?UTF-8?B?S2/FgsWCxIV0YWosIFJlbWlnaXVzeg==?= <remigiusz.kollataj@mobica.com>, Alexander Stein <alexander.stein@systec-electronic.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Uwe Bonnes <bon@elektron.ikp.physik.tu-darmstadt.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 11/04/2016 12:06 PM, Ramesh Shanmugasundaram wrote:
>> for now, IFLA_CAN_TERMINATION may be a boolean (or enumeration).
>
> ACK. We could start simple with a bool.

I would suggest to support a variable resistor (varistor) ranging from 1 
to 65534 Ohms and a list of discrete termination values as suggested.

diff --git a/include/uapi/linux/can/netlink.h 
b/include/uapi/linux/can/netlink.h
index 94ffe0c..a07601a 100644
--- a/include/uapi/linux/can/netlink.h
+++ b/include/uapi/linux/can/netlink.h
@@ -91,6 +91,32 @@ struct can_ctrlmode {
  	__u32 flags;
  };

+/*
+ * CAN hardware-dependent termination resistor constants
+ *
+ * Capabilities shown by ip tool if supported by CAN hardware
+ * Unsupported values are filled with zero (CAN_RESISTOR_INVALID)
+ */
+struct can_termination_const {
+
+	/* range for programmable resistor (if supported) */
+	__u16 range_low;	/* lowermost resistor value (Ohm) */
+	__u16 range_high;	/* highest resistor value (Ohm) */
+
+	/* array of supported discrete resistor values (Ohm) */
+	__u16 term[8];
+};
+
+/*
+ * CAN termination
+ */
+struct can_termination {
+	__u16 term;
+};
+
+#define CAN_RESISTOR_INVALID	0x0000U	/* indicates no value / unsupported */
+#define CAN_RESISTOR_DISABLED	0xFFFFU	/* indicates disabled termination */
+
  #define CAN_CTRLMODE_LOOPBACK		0x01	/* Loopback mode */
  #define CAN_CTRLMODE_LISTENONLY		0x02	/* Listen-only mode */
  #define CAN_CTRLMODE_3_SAMPLES		0x04	/* Triple sampling mode */
@@ -127,6 +153,8 @@ enum {
  	IFLA_CAN_BERR_COUNTER,
  	IFLA_CAN_DATA_BITTIMING,
  	IFLA_CAN_DATA_BITTIMING_CONST,
+	IFLA_CAN_TERMINATION,
+	IFLA_CAN_TERMINATION_CONST,
  	__IFLA_CAN_MAX
  };

With this interface the ip tool can get the capabilities of the 
termination analogue to the BITTIMING_CONST values.
And it can set the termination with IFLA_CAN_TERMINATION.

The CAN driver would provide a struct can_termination_const - in the 
case the CAN interface supports termination control.

E.g. the mcba_usb driver would provide this:

static struct can_termination_const = {
	.range_low = CAN_RESISTOR_INVALID;
	.range_high = CAN_RESISTOR_INVALID;
	.term = { 120, CAN_RESISTOR_DISABLED, CAN_RESISTOR_INVALID };
}

Another driver supporting 60 and 120 Ohms but no possibility to disable 
the termination:

static struct can_termination_const = {
	.range_low = CAN_RESISTOR_INVALID;
	.range_high = CAN_RESISTOR_INVALID;
	.term = { 60, 120, CAN_RESISTOR_INVALID };
}

Another driver supporting 60 to 5600 Ohms varistor and the possibility 
to disable the termination:

static struct can_termination_const = {
	.range_low = 60;
	.range_high = 5600;
	.term = { CAN_RESISTOR_DISABLED, CAN_RESISTOR_INVALID };
}

These termination capabilities might be provided by device tree 
configuration too - although I don't know how this would be done.

What do you think about this kind of configuration interface?

Regards,
Oliver

