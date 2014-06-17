From: Nikita Edward Baruzdin <nebaruzdin@gmail.com>
Subject: Re: SJA1000 loopback feature
Date: Tue, 17 Jun 2014 15:41:14 +0400
Message-ID: <CAEJ7JO1a_5Z2yKYDw30XjXh3qt4Qr-yRUVMUkz9s3MRv=zLWhA@mail.gmail.com>
References: <CAEJ7JO2ejHBVANYWXxXe_DstXCW-hm9xzJYXifiU+RwYNS3M1A@mail.gmail.com>
	<539F3DDF.70007@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-oa0-f47.google.com ([209.85.219.47]:33163 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755023AbaFQLlO (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 17 Jun 2014 07:41:14 -0400
Received: by mail-oa0-f47.google.com with SMTP id n16so8174780oag.34
        for <linux-can@vger.kernel.org>; Tue, 17 Jun 2014 04:41:14 -0700 (PDT)
In-Reply-To: <539F3DDF.70007@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org

On Mon, Jun 16, 2014 at 10:56 PM, Oliver Hartkopp <socketcan@hartkopp.net>
wrote:
> CAN_CTRLMODE_LOOPBACK means, that the controller is able to 'shortcut' the TX
> line with the RX line.

So that is what I called a hardware loopback. For SJA1000 it is done with the
SRR (Self Reception Request) feature. Note also that with SJA1000 you can't put
message from TX to RX buffer without actually sending it to the bus.

> This means that you send a CAN frame to your own input pin without the need
> for external CAN nodes (including acks).

And this is the STM (Self Test Mode) in SJA1000.

>> I attached a patch that adds support for the Self Test Mode using the
>> CAN_CTRLMODE_LOOPBACK netlink option. As it is not exactly a loopback mode we
>> enable with that option, it might be a better idea to have a separate one for
>> that, smth like CAN_CTRLMODE_SELF_TEST. What do you think?
>
> I think CAN_CTRLMODE_LOOPBACK still is the right description.
>
> But when you read the SJA1000 spec, you would need to set CMD_SRR (self
> reception request) instead of CMD_TR (transmission request) to have the
> loopback functionality when the MOD_STM (self test mode) is enabled, right?

Yes, but not necessarily. My point is: STM and SRR are in fact separate
features, so maybe they should be controlled separately. Of course, we can say
CAN_CTRLMODE_LOOPBACK = STM + SRR for SJA1000. But that is not what I wanted.

You see, we, for instance, don't really need hardware loopback for our case.
What we need is to have software loopback working. And for that STM is
necessary. If we enable SRR feature as well, we'll have each message loopbacked
twice: once by software (can_{put|get}_echo_skb() functions) and once by
hardware (message in controller's RX buffer). Thus we'll probably have to
disable the software loopback per socket (CAN_RAW_LOOPBACK option) which is not
really convenient.

Thanks for the quick response,
Nikita
