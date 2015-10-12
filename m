From: Guillaume Picquet <guillaume@picquet.fr>
Subject: Re: SocketCAN stops read after RX overflow, is it normal?
Date: Mon, 12 Oct 2015 10:05:06 +0200
Message-ID: <561B69B2.9010804@picquet.fr>
References: <55E6CCC8.7010908@picquet.fr> <55E80C74.8060600@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from bounce-1.online.net ([62.210.16.43]:33909 "EHLO
	bounce-1.online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751116AbbJLJCJ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 12 Oct 2015 05:02:09 -0400
Received: from [62.210.16.40] (helo=smtpauth-dc2-1.online.net)
	by bounce-dc2-1.online.net with esmtpa (Exim 4.82)
	(envelope-from <guillaume@picquet.fr>)
	id 1ZlY6b-0005DP-QK
	for linux-can@vger.kernel.org; Mon, 12 Oct 2015 10:05:13 +0200
In-Reply-To: <55E80C74.8060600@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

Hi Marc,

I've received a patched firmware from my provider, tested it and so far=
=20
so good.
I've connected 2 devices (AT91 based) at 1Mb/s.
So far more than 470000000 frames received so far.
 From the user-space point of view it's much better.
Now the only way to know if rx overflow occur is to set SO_RXQ_OVFL=20
flag, use recvmsg and check ancillary data.

Regards

Guillaume.

Le 03/09/2015 11:01, Marc Kleine-Budde a =C3=A9crit :
> On 09/02/2015 12:17 PM, Guillaume Picquet wrote:
>> Hi every one.
>>
>> I=E2=80=99m not sure to post to the correct list, if so please corre=
ct me.
> 100% correct.
>
>> I=E2=80=99m doing tests on embedded hardware with integrated CAN bus=
 interface
>> (based on AT91). The driver provides Linux Socket API and I try to s=
ee
>> the limits:
>> I have one transmitter that writes CAN frames (CAN_RAW) as fast as
>> possible and a receiver that reads continuously.
>> After a moment the receiver gets an error frame signalling RX overfl=
ow.
>> I have no problem with that, it's normal and expected.
>> But question is why at this point no more frame is received ?
> It's probably a bug in the driver.
>
>> read() do not return, I've tested also with select() which return ti=
meout.
>> (The restart-ms option is set)
>>
>> I expected some dropped frames and others RX buffer errors but not t=
he
>> end of reception.
>>
>> The only way to recover the interface is to set it down and up again=
=2E
> Try the patches I send you in the other mail. They switch the at91 to
> the new infrastructure. Some generic testing show good results, but i=
t
> seems you have a harder/better test case.
>
> Hope that helps, please keep us informed,
> Marc
>

