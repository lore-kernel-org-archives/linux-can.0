From: Yang Wang <wang701@purdue.edu>
Subject: Re: Re: can-j1939 API
Date: Tue, 17 Nov 2015 01:01:10 -0500
Message-ID: <CAEE8DsJvGNk6pbnKBPJTHJhjcgTihuHtPem254U_9oWP3NjfHQ@mail.gmail.com>
References: <linux-can/can-utils/pull/7/c144149208@github.com>
	<560ADC91.1090408@pengutronix.de>
	<20150929194920.GA11430@airbook.vandijck-laurijssen.be>
	<CAFUozzFQTOASSR94vKQnMGajUSvHGgL7BMuJSvuXKd3=n6aiog@mail.gmail.com>
	<20151018023225.GA29078@airbook.vandijck-laurijssen.be>
	<CAFUozzGy0UZhKaeLfJiySkJfrK-XuOD7cwz01=hsO48hAk+mow@mail.gmail.com>
	<20151019204442.GA16852@airbook.vandijck-laurijssen.be>
	<CAFUozzFqDtOdkgFye4M3jU-g+9uF=XH8SmU44j5qK4PTEXp8qQ@mail.gmail.com>
	<20151023111430.GB22388@airbook.eia.lan>
	<5642686F.5020708@purdue.edu>
	<20151111184947.GA6182@airbook.vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailhub248.itcs.purdue.edu ([128.210.5.248]:52285 "EHLO
	mailhub248.itcs.purdue.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751151AbbKQGBM (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 17 Nov 2015 01:01:12 -0500
Received: from mail-yk0-f179.google.com (mail-yk0-f179.google.com [209.85.160.179])
	(authenticated bits=0)
	by mailhub248.itcs.purdue.edu (8.14.4/8.14.4/mta-auth.smtp.purdue.edu) with ESMTP id tAH61Ao4008594
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-can@vger.kernel.org>; Tue, 17 Nov 2015 01:01:11 -0500
Received: by ykdv3 with SMTP id v3so275189940ykd.0
        for <linux-can@vger.kernel.org>; Mon, 16 Nov 2015 22:01:10 -0800 (PST)
In-Reply-To: <20151111184947.GA6182@airbook.vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: dev.kurt@vandijck-laurijssen.be
Cc: Alex Layton <alex@layton.in>, linux-can <linux-can@vger.kernel.org>

On Wed, Nov 11, 2015 at 1:49 PM, Kurt Van Dijck
<dev.kurt@vandijck-laurijssen.be> wrote:
>
> The fixes I need to do don't affect the API.
> The upcoming changes to can-j1939 do not yet affect the socket API,
> they rather affect how iproute2 is needed (I plan to drop the need for it).
>
> I'm not so familiar with JNI etc. I assume that the whole iproute2 thing
> would stay out of it alltogether?
>
> Kind regards,
> Kurt

Yes. I am inclined to use the stock iproute2 if possible.

I did compile your newest branch (j1939-v3.15x) on kernel source tree.
After booting into the kernel, it seems like the j1939 switch will not
work on a CAN interface unless your version of iproute2 is installed.

I will begin writing the JNI wrapper for j1939 but how soon do you
plan on dropping the need on iproute2?

Regards,
Yang
