From: Andrew Bell <andrew.bell.ia@gmail.com>
Subject: Re: What are you doing if the TX buffer overflows?
Date: Mon, 17 Sep 2012 14:26:13 -0500
Message-ID: <CACJ51z1g+A2Hy5SXU=1AmwyDYRuxv=MzsyVjAwiRWaOSRn+h7A@mail.gmail.com>
References: <2478881.znSzbTXnK5@uschi>
	<505777BC.3000705@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:42569 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932417Ab2IQT0O convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 17 Sep 2012 15:26:14 -0400
Received: by oago6 with SMTP id o6so5164722oag.19
        for <linux-can@vger.kernel.org>; Mon, 17 Sep 2012 12:26:13 -0700 (PDT)
In-Reply-To: <505777BC.3000705@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: =?ISO-8859-1?Q?Heinz=2DJ=FCrgen_Oertel?= <oe@port.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On Mon, Sep 17, 2012 at 2:19 PM, Oliver Hartkopp <socketcan@hartkopp.ne=
t> wrote:
> Hello Heinz,
>
> On 17.09.2012 15:58, Heinz-J=FCrgen Oertel wrote:
>
>>
>> is there a way to empty the tx buffer ?
>
>
> Usually the buffer does not get empty due to a problem of the CAN con=
troller
> and/or the CAN network.
>
> So even if you could flush the queue the CAN controller is probably s=
till
> stuck with his processed frame.

On my interface, the TX frames time out after one second.  But I could
find nothing in the spec to say that this is how things should
operate.  Is this driver-specific or is there something in a document
that says how retransmission and timeouts works?

Thanks,

--=20
Andrew Bell
andrew.bell.ia@gmail.com
