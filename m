From: Sebastian Haas <dev@sebastianhaas.info>
Subject: Re: adding can4linux to drivers/char
Date: Sun, 29 Sep 2013 19:45:09 +0200
Message-ID: <CADGMhsXTbEc5ifQEbNM=dS3OP6uwGrvGfZ3OCvWJ=aXJyzGs+A@mail.gmail.com>
References: <1881932.U1kQQJkqCz@heinz.site>
	<523DF9C1.30300@grandegger.com>
	<2109885.0l6dWmo4a5@heinz.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtprelay03.ispgateway.de ([80.67.31.37]:43379 "EHLO
	smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754620Ab3I2RpN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 29 Sep 2013 13:45:13 -0400
Received: from [209.85.216.173] (helo=mail-qc0-f173.google.com)
	by smtprelay03.ispgateway.de with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.68)
	(envelope-from <dev@sebastianhaas.info>)
	id 1VQL3O-0003ym-Hm
	for linux-can@vger.kernel.org; Sun, 29 Sep 2013 19:45:10 +0200
Received: by mail-qc0-f173.google.com with SMTP id c3so3062104qcv.32
        for <linux-can@vger.kernel.org>; Sun, 29 Sep 2013 10:45:09 -0700 (PDT)
In-Reply-To: <2109885.0l6dWmo4a5@heinz.site>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?ISO-8859-1?Q?Heinz=2DJ=FCrgen_Oertel?= <hj.oertel@t-online.de>
Cc: linux-can@vger.kernel.org

I think Heinz-J=FCrgens' arguments are not that wrong. There are a bunc=
h
of example in the kernel of concurring solution for the same issues
every single one with different advantages and disadvantages (just
compare how many solution for virtualization are available kvm, xen,
paravirt, ...).

There must be space in kernel for the classical chardev CAN-approach.
Sharing common code to access the different controllers must be
possible.

I think there are a bunch of use cases out there which are easier and
more efficiently solved with a simple chardev API. A simple chardev
CAN driver like can4linux provide doesn't depend on the whole
networking subsystem which may be imported of real embedded systems
with strong memory constraints (less memory footprint, smaller
kernel).

The Socket approach has some real advantages (multi-user for single
CAN controller, iptables filtering, netutil integration, buffering,
=2E.), but many of them may be considered as disadvantages as well (no
control of the message flow in terms of timing and ordering, no
exclusive use of the interface, networking dependency). Implementing
an automatic bitrate detection or application driver busoff recovery
is a pain in the ass with SocketCAN.

-Sebastian

2013/9/29 Heinz-J=FCrgen Oertel <hj.oertel@t-online.de>:
>
> Hello
>
> Am Samstag, 21. September 2013, 21:55:45 schrieb Wolfgang Grandegger:
>> I think you need *strong* arguments to get it accepted.
>
> I have some good arguments for this kind of driver
> - it is much more simple in design than others,
>   simplicity is one of the Linux design goals
> - It has a simple user API
> - It does not need any other infrastructure than the kernel API
> - It is mature
>
> I agree, it would be nice to share the low level CAN controller relat=
ed
> experiences of the developers. That is may be something we can share =
if we
> could agree of a set of CAN controller header files with shared regis=
ter
> #defines. And a set of very basic functions like initialize and activ=
ate CAN,
> set acceptance filters, transmit and receive, read out error register=
 or
> whatever.
> But to stay simple, I don't like the idea to have another additional =
layer
> around SocketCAN as layer below the can4linux API.
>
> Linux offers real diversity on the desktop, why not with drivers? Lin=
ux also
> has different sound devices and architectures.  Why not offering two =
different
> CAN driver concepts to the application programmer,
> let she decide what to use.
>
> --
> mit freundlichen Gr=FC=DFen
>        Heinz-J=FCrgen Oertel
