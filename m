From: Andri Yngvason <andri.yngvason@marel.com>
Subject: Re: using VCAN interfaces with containers
Date: Mon, 17 Oct 2016 10:47:50 +0000
Message-ID: <147670126999.12954.15947433823240101893@maxwell>
References: <e2bccb97-c0b8-617b-a6e3-b273a05f48e8@crocobox.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-db5eur01on0049.outbound.protection.outlook.com ([104.47.2.49]:42352
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933268AbcJQM2N (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 17 Oct 2016 08:28:13 -0400
In-Reply-To: <e2bccb97-c0b8-617b-a6e3-b273a05f48e8@crocobox.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?utf-8?q?Micka=C3=ABl_Gu=C3=A9rin?= <kael@crocobox.org>, linux-can@vger.kernel.org

Quoting Micka=C3=ABl Gu=C3=A9rin (2016-10-16 13:22:41)
> Hello,
> =

> I have a software that I would like to test inside LXC or nspawn =

> container. This software uses CAN and ethernet.
> =

> I need a way to have VCAN interface(s) allowing communication between =

> host and container. (Something like veth ?)
> =

>  From what I know it is not possible to "peer" two VCAN interfaces. It's =

> also not possible to have the same VCAN interface in two namespaces.
> =

> =

> Can anyone tell me if this is possible (without sharing the same network =

> namespace) ?
...

Hi Micka=C3=ABl,

Network namespaces are not implemented for SocketCAN. I actually tried addi=
ng
them a year ago [1], but I ran into trouble on multi-core systems. You are =
free
to pick up where I left off. ;)

I found other means by which to achieve my goals, so I gave up on adding the
namespaces. I created an abstraction that allowed me to forward CAN frames =
over
TCP [2]. This method has the downside the you need to embed it into your co=
de,
but it's easier to do this that to implement net namespaces for CAN.

On the host, I run a "bridge" [3] that opens the CAN interface and listens =
to
TCP. The LXC guest connects to the TCP server via the interface defined in
sock.h.

I hope this helps.

Best regards,
Andri

[1] http://marc.info/?l=3Dlinux-can&m=3D144337815016037
[2] https://github.com/marel-keytech/openCANopen/blob/master/src/sock.c
[3] https://github.com/marel-keytech/openCANopen/blob/master/src/canbridge.c
