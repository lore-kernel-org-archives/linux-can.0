From: "Valler, Robert" <r.valler@enextra.de>
Subject: RE: [Socketcan-users] Finding a transmitter's CAN ID
Date: Wed, 21 Aug 2013 13:41:26 +0000
Message-ID: <BB60414AA9EB294DA42EBCE12106C45A03AA1486@EX10MBOX1B.hosting.inetserver.de>
References: <1376923439605-7678.post@n3.nabble.com>,<521232ED.4050607@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mx-relay04.cloudservice.ag ([81.20.94.241]:52727 "EHLO
	mx-relay04.cloudservice.ag" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751813Ab3HUNsD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 21 Aug 2013 09:48:03 -0400
Received: from EX10HUB1.hosting.inetserver.de (unknown [10.20.10.69])
	by qhexrelay2.hosting.inetserver.de (Postfix) with ESMTP id 3EE6F18710D
	for <linux-can@vger.kernel.org>; Wed, 21 Aug 2013 15:41:27 +0200 (CEST)
In-Reply-To: <521232ED.4050607@pengutronix.de>
Content-Language: en-GB
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hello again,

Thanks all for the helpful information.
I am a little clearer on how the CAN bus works now.


All the best,
Rob



On 08/19/2013 04:43 PM, Rob__V wrote:
> Hi all,
>
> I am currently working on a project with several embedded platforms connect
> via CAN:
> 1 x Linux board connected via SocketCAN
> N x embedded boards using the Atmega16M1 (CAN) MCU.
>
> The Linux board is 'treated' as the master and needs to know the CAN ID of
> each
> atmega board that sends it a CAN message. So my question is :
>
> How is the Linux/SocketCAN board able to determine the CAN ID of other
> networked nodes when they transmit ?
>
> Of course, each CAN node can determine the target ID for each message but
> I am not sure if the source ID is known ... outside of arbitration.
>
>
> Thank you for your time.
>
> All the best,
> Rob
>
>
>
> --
> View this message in context: http://socket-can.996257.n3.nabble.com/Finding-a-transmitter-s-CAN-ID-tp7678.html
> Sent from the Socket-CAN Users mailing list archive at Nabble.com.
> _______________________________________________
> Socketcan-users mailing list
> Socketcan-users@lists.berlios.de
> https://lists.berlios.de/mailman/listinfo/socketcan-users
>

