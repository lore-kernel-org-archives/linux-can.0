From: Yang Wang <wang701@purdue.edu>
Subject: Re: RFC: can-j1939
Date: Mon, 22 Feb 2016 13:24:14 -0500
Message-ID: <CAEE8DsL+LyhRKJQ7qq0QfNhKR21qEDYog+vAS8cFcr8d9ZxQ6A@mail.gmail.com>
References: <20160222052231.GA2022@airbook.vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailhub248.itcs.purdue.edu ([128.210.5.248]:54803 "EHLO
	mailhub248.itcs.purdue.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751589AbcBVSlE (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 22 Feb 2016 13:41:04 -0500
Received: from mail-oi0-f41.google.com (mail-oi0-f41.google.com [209.85.218.41])
	(authenticated bits=0)
	by mailhub248.itcs.purdue.edu (8.14.4/8.14.4/mta-auth.smtp.purdue.edu) with ESMTP id u1MIOEvv006593
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-can@vger.kernel.org>; Mon, 22 Feb 2016 13:24:15 -0500
Received: by mail-oi0-f41.google.com with SMTP id m82so60929070oif.1
        for <linux-can@vger.kernel.org>; Mon, 22 Feb 2016 10:24:15 -0800 (PST)
In-Reply-To: <20160222052231.GA2022@airbook.vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: dev.kurt@vandijck-laurijssen.be, Alex Layton <alex@layton.in>, David Jander <david@protonic.nl>, laurent vaudoit <laurent.vaudoit@gmail.com>, Oliver Hartkopp <socketcan@hartkopp.net>, linux-can <linux-can@vger.kernel.org>

On Mon, Feb 22, 2016 at 12:22 AM, Kurt Van Dijck
<dev.kurt@vandijck-laurijssen.be> wrote:

> * it is stable, works with the latest kernels.
> * does not need or use netlink. You don't need a modified iproute2 anymore
> * when a can-j1939 socket binds to an interface, can-j1939 starts
>   processing on this interface: address claim tracking + transport
>   protocol assembly.
>   when the last such socket closes, can-j1939 stops for that interface.
>   This also means that a transport protocol session that _started_ before
>   the first socket opens will not be seen by can-j1939. This conforms to
>   datagram communication.
> * when a socket binds to an address or name, the kernel starts treating
>   that address/name as a local one.
> * The new stack takes less measures to detect address collisions
>   for static addresses, and keeps more responsibility to the user.
> * non-root users can start can-j1939 on an interface, add addresses, ...
> * a list of current local addresses is available in /proc
> * add transport protocol parameter, to control outgoing inter-packet delays.
> * add parameter to pad all packets to 8 bytes.

Kurt,

It looks great. Dropping the usage of iproute2 simplifies a lot of
things for me. I'll test the v3.15 branch since I've been using it.

Thank you for the work.

Regards,
Yang
