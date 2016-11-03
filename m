From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Adding new CAN driver
Date: Thu, 3 Nov 2016 16:50:25 +0100
Message-ID: <5f302213-c072-b6b8-aa78-4bc405dc167d@hartkopp.net>
References: <CAKT-o-cOb0sqRmvH+BKjX4yvBLp5_GqVd6=ifr2jm5T75-hcZA@mail.gmail.com>
 <3113364.8FuUfmAlHQ@ws-stein>
 <SG2PR06MB1038F0416E850F0C09BC5CCEC3A00@SG2PR06MB1038.apcprd06.prod.outlook.com>
 <1490105.s3iJfGbYsS@ws-stein>
 <CAKT-o-cJ3UwD=xakh7-hF5101rS2zCa5AHfjBvdRNATJD+Weqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.221]:19528 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758405AbcKCPu7 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 3 Nov 2016 11:50:59 -0400
In-Reply-To: <CAKT-o-cJ3UwD=xakh7-hF5101rS2zCa5AHfjBvdRNATJD+Weqw@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?UTF-8?B?S2/FgsWCxIV0YWosIFJlbWlnaXVzeg==?= <remigiusz.kollataj@mobica.com>, Alexander Stein <alexander.stein@systec-electronic.com>
Cc: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Uwe Bonnes <bon@elektron.ikp.physik.tu-darmstadt.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>

On 11/02/2016 07:03 PM, Kołłątaj, Remigiusz wrote:
> On 2 November 2016 at 17:08, Alexander Stein
> <alexander.stein@systec-electronic.com> wrote:
>> On Wednesday 02 November 2016 15:49:50, Ramesh Shanmugasundaram wrote:

>>> But this is physical layer information as Oliver mentioned. The CAN
>>> transceiver may even require some start-up state that may be enabled by
>>> setting couple of GPIOs (as on my board). Yes, it is part of the CAN
>>> interface configuration but it not part of the CAN controller driver. I
>>> think we could map it to Ethernet MAC & PHY case - isn't it?

IIRC there's some mii-tool to configure, view & manipulate 
media-independent interface status:

http://man7.org/linux/man-pages/man8/mii-tool.8.html

At least the ethernet people found a way to configure their transceiver 
part with this tool.

>> The transceiver might be managed by regulators as done by e.g. flexcan. This
>> is part of the hardware description, so device tree here is fine.
>> But in my opinion bus termination is an end user configuration which might
>> change rather often than not. It might be independent of the controller driver
>> as e.g. in flexcan, but it might be part of the device as in USB hardware
>> which requires some specific command to change bus termination.
>> IMHO it makes no sense to split an USB interface driver into two parts using
>> the same interface in the end.

ack.

> I agree that termination is a physical layer setting but to be
> specific in case of Microchip's CAN BUS it is neither related to CAN
> controller nor transceiver.

So what about creating TWO new netlink configuration options:

diff --git a/include/uapi/linux/can/netlink.h 
b/include/uapi/linux/can/netlink.h
index 94ffe0c..8d7c4b9 100644
--- a/include/uapi/linux/can/netlink.h
+++ b/include/uapi/linux/can/netlink.h
@@ -127,6 +127,8 @@ enum {
         IFLA_CAN_BERR_COUNTER,
         IFLA_CAN_DATA_BITTIMING,
         IFLA_CAN_DATA_BITTIMING_CONST,
+       IFLA_CAN_TRX_CTRL,
+       IFLA_CAN_TERMINATION,
         __IFLA_CAN_MAX
  };

Where IFLA_CAN_TRX_CTRL provides an interface to configure the 
transceiver and IFLA_CAN_TERMINATION to configure the termination.

But for IFLA_CAN_TERMINATION we need some possibility to configure 
either a set of supported termination resistors (e.g. disabled, 60 Ohms, 
120 Ohms, xxx Ohms, ...) or a free termination value (e.g. 1 Ohm - 10 
kOhms) following the hardware capabilities of the CAN device.
Therefore a list of values and ranges has to be made available by the 
netlink interface before userspace can select some of them.

Both IFLA_CAN_TRX_CTRL and IFLA_CAN_TERMINATION would only be supported 
if the CAN device can handle them. Probably a device tree decription 
defines a fixed configuration which can be read but not modified.

Any ideas/comments on this?

Regards,
Oliver

