From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: What are you doing if the TX buffer overflows?
Date: Mon, 17 Sep 2012 21:33:23 +0200
Message-ID: <50577B03.60105@hartkopp.net>
References: <2478881.znSzbTXnK5@uschi> <505777BC.3000705@hartkopp.net> <CACJ51z1g+A2Hy5SXU=1AmwyDYRuxv=MzsyVjAwiRWaOSRn+h7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:37420 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932502Ab2IQTdZ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 17 Sep 2012 15:33:25 -0400
In-Reply-To: <CACJ51z1g+A2Hy5SXU=1AmwyDYRuxv=MzsyVjAwiRWaOSRn+h7A@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Andrew Bell <andrew.bell.ia@gmail.com>
Cc: =?ISO-8859-1?Q?Heinz-J=FCrgen_Oertel?= <oe@port.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 17.09.2012 21:26, Andrew Bell wrote:

> On Mon, Sep 17, 2012 at 2:19 PM, Oliver Hartkopp <socketcan@hartkopp.=
net> wrote:
>> Hello Heinz,
>>
>> On 17.09.2012 15:58, Heinz-J=FCrgen Oertel wrote:
>>
>>>
>>> is there a way to empty the tx buffer ?
>>
>>
>> Usually the buffer does not get empty due to a problem of the CAN co=
ntroller
>> and/or the CAN network.
>>
>> So even if you could flush the queue the CAN controller is probably =
still
>> stuck with his processed frame.
>=20
> On my interface, the TX frames time out after one second.  But I coul=
d
> find nothing in the spec to say that this is how things should
> operate.  Is this driver-specific or is there something in a document
> that says how retransmission and timeouts works?
>=20


The TX timeout functionality has been removed a long time ago. There wa=
s a
discussion about that topic that days.

So what kind of driver do you have there? A PEAK PCAN driver?

Regards,
Oliver
