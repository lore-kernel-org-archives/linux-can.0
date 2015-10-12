From: Guillaume Picquet <guillaume@picquet.fr>
Subject: Re: SocketCAN stops read after RX overflow, is it normal?
Date: Mon, 12 Oct 2015 11:46:55 +0200
Message-ID: <561B818F.8060100@picquet.fr>
References: <55E6CCC8.7010908@picquet.fr> <55E80C74.8060600@pengutronix.de>
 <561B69B2.9010804@picquet.fr> <561B7556.3050206@pengutronix.de>
 <561B7781.4040906@picquet.fr> <561B7A3C.20500@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtpauth.online.net ([62.210.16.40]:48458 "EHLO
	smtpauth-dc2-1.online.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751178AbbJLJq6 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 12 Oct 2015 05:46:58 -0400
In-Reply-To: <561B7A3C.20500@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org



Le 12/10/2015 11:15, Marc Kleine-Budde a =C3=A9crit :
> On 10/12/2015 11:04 AM, Guillaume Picquet wrote:
>> Le 12/10/2015 10:54, Marc Kleine-Budde a =C3=A9crit :
>>> On 10/12/2015 10:05 AM, Guillaume Picquet wrote:
>>>> I've received a patched firmware from my provider, tested it and s=
o far
>>>> so good.
>>> Good to hear that. Can you send the patches or at91_can.c to the li=
st?
>> It's your patch I gave my provider.
>>
>> https://git.kernel.org/cgit/linux/kernel/git/mkl/linux-can-next.git/=
commit/?h=3Dat91-next&id=3D7234e9dee7d0df75de7ae14443a2306435750594
> Ah, good to hear that this works for your usecase aswell. Can I add y=
our
> Tested-by Tag to the patch?
Yes why not, But I can not guarantee that my provider did not modify th=
e=20
patch.
>
>>>> I've connected 2 devices (AT91 based) at 1Mb/s.
>>>> So far more than 470000000 frames received so far.
>>>>    From the user-space point of view it's much better.
>>>> Now the only way to know if rx overflow occur is to set SO_RXQ_OVF=
L
>>>> flag, use recvmsg and check ancillary data.
>>> No, that's not correct. With SO_RXQ_OVFL you'll detect overflows of=
 the
>>> socket. When there are overflows in the hardware the rx overrun in =
per
>>> device statistics will be increased (see ifconfig) output.
>> Ok good to know.
>> So your saying that if I receive nothing on a socket with CAN_ERR_MA=
SK
>> set 0x1FFFFFFFU it means that the hardware is handling CAN traffic w=
ell !
> Yes.
Good.
>
> Marc
>
Thanks

Guillaume
