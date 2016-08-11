From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: SocketCAN device enumeration API
Date: Thu, 11 Aug 2016 12:05:58 +0200
Message-ID: <20160811100558.GA2147@airbook.newtec.eu>
References: <201d5fca-9ea8-aa0e-843e-f21441cd7170@gmx.de>
 <20160809140453.GE25116@airbook.newtec.eu>
 <e7d06ad8-579d-0053-c7e5-ddc8feee673b@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay-b02.edpnet.be ([212.71.1.222]:43897 "EHLO
	relay-b02.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752240AbcHKKGa (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 11 Aug 2016 06:06:30 -0400
Content-Disposition: inline
In-Reply-To: <e7d06ad8-579d-0053-c7e5-ddc8feee673b@gmx.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?utf-8?B?QW5kcsOp?= Hartmann <aha_1980@gmx.de>
Cc: linux-can@vger.kernel.org, Mirza Krak <mirza.krak@gmail.com>

> Hello Kurt and Mirza,
> 
> thanks for your pointers, I did already did search time, but haven't found
> much useful.
> 
> Kurt, your library does exactly what I need. I was impressed (and a bit
> shocked), how much code is necessary to do this work.

I too think netlink was as such not designed to be an end-user
interface, but a generic mechanism to create libraries like
libsocketcan, of libenumif.

> I think (parts of)
> your library would also make a good extension to libsocketcan, as it seems
> I'm not the only one asking, so there is definitely a need for this
> function.

Well, libsocketcan could copy part of the code for easy CAN enumeration.
libenumif is not really restricted to CAN, or any other type.

> 
> However, the only possiblity I see for me now, would be to ship a copy of
> libenumif along with Qt and to integrate it into Qt's build system for
> cross-platform builds.

When you ship libenumif along with QT, doesn't that imply that it should
stay out of QT.
Or did you mean to ship libenumif as shared object along with QT's
shared objects?

> 
> Thats where my problems begin. I neither know about the technical, nor the
> legal possibilities to do so :(

QT is not my technical competence.
Legally, libenumif is shipped with LGPLv3. I don't see a problem
shipping it. LGPL allows to use the library (as shared object) from
non-GPL code AFAIK.

Kurt
