From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: SJA1000 loopback feature
Date: Mon, 16 Jun 2014 20:56:31 +0200
Message-ID: <539F3DDF.70007@hartkopp.net>
References: <CAEJ7JO2ejHBVANYWXxXe_DstXCW-hm9xzJYXifiU+RwYNS3M1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.220]:26329 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751349AbaFPS4e (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 16 Jun 2014 14:56:34 -0400
In-Reply-To: <CAEJ7JO2ejHBVANYWXxXe_DstXCW-hm9xzJYXifiU+RwYNS3M1A@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Nikita Edward Baruzdin <nebaruzdin@gmail.com>, linux-can@vger.kernel.org

Hello Nikita,

On 16.06.2014 18:20, Nikita Edward Baruzdin wrote:

> We have several logical units working on the same CAN interface of a
> SJA1000-based CAN controller. We need them to communicate with each other even
> in a situation of one physical node on the bus. Thus we need some kind of a
> loopback functionality for that. Software loopback works fine aside from the
> fact it is performed only after an actual transmission has happened (which is a
> problem with a one-node bus).
> 
> There is a CAN_CTRLMODE_LOOPBACK netlink option, but I didn't find any
> description of its semantics. And as far as I understand every controller
> interpretes it in its own way. For example, MCP2510 implies the loopback mode is
> a silent (listen-only) mode and Bosch C_CAN controller disregards actual
> rx-input in this mode according to the documentation. Hence the first question
> is: what does CAN_CTRLMODE_LOOPBACK mean precisely?

CAN_CTRLMODE_LOOPBACK means, that the controller is able to 'shortcut' the TX
line with the RX line.

This means that you send a CAN frame to your own input pin without the need
for external CAN nodes (including acks).

> I've also found out that this option is not implemented for SJA1000. Actually,
> SJA1000 has nothing called a "loopback" feature but instead it has a Self Test
> Mode, that seems like a reasonable solution for our problem. In this mode no
> acknowledgement is required for the successful transmission, so software
> loopback is working. However, it is not in the SJA1000 driver at the moment.
> 
> It is also possible to have the hardware loopback for SJA1000 with the Self
> Reception Request feature (a message is transmitted and received simultaneously,
> not implemented in sja1000 module as well), although we don't need it for our
> specific case.
> 
> So the next question is: how should we implement those features for SJA1000?

Oh, yes - why not :-)

> 
> I attached a patch that adds support for the Self Test Mode using the
> CAN_CTRLMODE_LOOPBACK netlink option. As it is not exactly a loopback mode we
> enable with that option, it might be a better idea to have a separate one for
> that, smth like CAN_CTRLMODE_SELF_TEST. What do you think?

I think CAN_CTRLMODE_LOOPBACK still is the right description.

But when you read the SJA1000 spec, you would need to set CMD_SRR (self
reception request) instead of CMD_TR (transmission request) to have the
loopback functionality when the MOD_STM (self test mode) is enabled, right?

For the next patch post, please send the patch inline - so that is can be
reviewed and answered easier.

Many thanks,
Oliver

