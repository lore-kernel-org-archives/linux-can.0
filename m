From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: adding can4linux to drivers/char
Date: Sun, 29 Sep 2013 21:41:44 +0200
Message-ID: <52488278.4030603@grandegger.com>
References: <1881932.U1kQQJkqCz@heinz.site> <523DF9C1.30300@grandegger.com> <2109885.0l6dWmo4a5@heinz.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:59643 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755611Ab3I2Tlt (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 29 Sep 2013 15:41:49 -0400
In-Reply-To: <2109885.0l6dWmo4a5@heinz.site>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?ISO-8859-1?Q?Heinz-J=FCrgen_Oertel?= <hj.oertel@t-online.de>, linux-can@vger.kernel.org

On 09/29/2013 06:28 PM, Heinz-J=FCrgen Oertel wrote:
>=20
> Hello
>=20
> Am Samstag, 21. September 2013, 21:55:45 schrieb Wolfgang Grandegger:
>> I think you need *strong* arguments to get it accepted.=20
>=20
> I have some good arguments for this kind of driver
> - it is much more simple in design than others,
>   simplicity is one of the Linux design goals
> - It has a simple user API
> - It does not need any other infrastructure than the kernel API
> - It is mature

Well, the question is in what respect it's (much) better than the
existing Linux-CAN. I can imagine some performance benefits on very low
end systems, if at all.

> I agree, it would be nice to share the low level CAN controller relat=
ed=20
> experiences of the developers. That is may be something we can share =
if we=20
> could agree of a set of CAN controller header files with shared regis=
ter=20
> #defines. And a set of very basic functions like initialize and activ=
ate CAN,=20
> set acceptance filters, transmit and receive, read out error register=
 or=20
> whatever.

Sounds ugly!

> But to stay simple, I don't like the idea to have another additional =
layer=20
> around SocketCAN as layer below the can4linux API.
>=20
> Linux offers real diversity on the desktop, why not with drivers? Lin=
ux also=20
> has different sound devices and architectures.  Why not offering two =
different=20
> CAN driver concepts to the application programmer,
> let she decide what to use.


It's also about maintenance. It's real work to keep a driver in the
kernel up-to-date, to review and accept new drivers, etc., not only for
the initial submitter.

There are missing bits and pieces in Linux-CAN, e.g. hardware filter
support, improved bus-off handling or even bitrate detection. That's
also not a strong argument for can4linux. Just contribute them to Linux=
-CAN.

Wolfgang.

