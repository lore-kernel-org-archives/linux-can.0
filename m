From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: j1939: recv >8 bytes
Date: Mon, 28 Sep 2015 10:58:05 +0200
Message-ID: <20150928085805.GA16669@airbook>
References: <CAKoHjFzLoME76fmon+O7oS5_pKQk2j7QujnMsOfL7aLrr8xDWg@mail.gmail.com>
 <20150925082846.GA7002@airbook>
 <CAKoHjFxUqnPb+QEnTUjEinQHWjhiO-2kwapyjza1iFvGGg2C6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relaygateway02.edpnet.net ([212.71.1.211]:57362 "EHLO
	relaygateway02.edpnet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757045AbbI1I6Q convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 28 Sep 2015 04:58:16 -0400
Content-Disposition: inline
In-Reply-To: <CAKoHjFxUqnPb+QEnTUjEinQHWjhiO-2kwapyjza1iFvGGg2C6g@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Mark Santacesaria <mark@keeptruckin.com>
Cc: linux-can@vger.kernel.org

Hi Mark,

see my comments below,

--- Original message ---
> Date: Sun, 27 Sep 2015 22:24:33 -0400
> From: Mark Santacesaria <mark@keeptruckin.com>
> To: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
> Subject: Re: j1939: recv >8 bytes
>=20
>    hey Kurt.... thanks again for the help.... i was hoping to ask you
>    something else.... the three main things that i want to do are:
>    - request and receive an address claim

You may take a look at jacd, in my can-utils j1939 branch.

>    - request and receive a VIN
>    - listen to the traffic to monitor a handful of messages
>    i was planning on setting up a state machine that handles sending =
the
>    messages and a receive section that takes in all of the messages a=
nd
>    processes them..... i think this should work fine except as you
>    mentioned in your reply the number of bytes received is specified =
so
>    can i set up to listen to single packet and multi-packet messages =
at
>    the same time? =C2 i may not know the order that things are going =
to be
>    received....

The #bytes you give to the recv() call is the size of the buffer.
The #received bytes is the return value (if successfull).

So, a single
	ret =3D recv(sock, buf, sizeof(buf), 0);

may receive single packet & multi-packet. My goal was to make this
transparent indeed. Just make sure the buffer 'buf' is big enough
to receive the largest packet that you expect.
'ret' may be 8, <8, or >8, or in case of failure, <0.

Kind regards,
Kurt

>    thanks!!!=C2  I appreciate the help a bunch...
>=20
>    On Fri, Sep 25, 2015 at 4:28 AM, Kurt Van Dijck
>    <[1]dev.kurt@vandijck-laurijssen.be> wrote:
>=20
>      Hi Mark,
>      I added linux-can mailing list in CC, and altered the subject.
>      See my answer to your question below.
>      --- Original message ---
>      > Date: Thu, 24 Sep 2015 11:21:48 -0400
>      > From: Mark Santacesaria <[2]mark@keeptruckin.com>
>      > To: [3]kurt.van.dijck@eia.be
>      > Subject: j1939 linux kernel...
>      >
>      >=C2  =C2  hey kurt.... thanks for the effort that you put in to=
 the
>      j1939
>      >=C2  =C2  code.... i was trying to receive a VIN request which =
is a
>      multi-packet
>      >=C2  =C2  message, and while i found examples of sending more t=
hat 8
>      bytes but i
>      >=C2  =C2  am not sure how to receive.....
>      A "multi-packet message" is treated as a single j1939 packet.
>      You receive it like any other j1939 packet:
>      =C2  =C2  =C2  =C2  uint8_t buf[1024];
>      =C2  =C2  =C2  =C2  int ret;
>      =C2  =C2  =C2  =C2  ret =3D recv(sock, buf, sizeof(buf), 0);
>      will receive up to 1024 bytes from the next j1939 packet.
>      You may use any buffer size you like here.
>      see also
>      =C2  =C2  =C2  =C2  man recv
>      Kind regards,
>      Kurt
>=20
>    --
>    Mark Santacesaria
>    Design Engineer
>    Keep Truckin
>    716-208-9681
>    KeepTruckin logo
>=20
> References
>=20
>    1. mailto:dev.kurt@vandijck-laurijssen.be
>    2. mailto:mark@keeptruckin.com
>    3. mailto:kurt.van.dijck@eia.be
