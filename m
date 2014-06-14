From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: Re: CAN Bus over TCP/IP
Date: Sat, 14 Jun 2014 07:25:26 +0200
Message-ID: <CAGm1_ksAyAODL0ZL4KuFUrPUpsCk1pAgpU7GxpNNearT4w0Caw@mail.gmail.com>
References: <20140614015522.GC9911@griso.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:34009 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751999AbaFNFZq (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 14 Jun 2014 01:25:46 -0400
Received: by mail-pd0-f181.google.com with SMTP id v10so1849878pde.26
        for <linux-can@vger.kernel.org>; Fri, 13 Jun 2014 22:25:46 -0700 (PDT)
In-Reply-To: <20140614015522.GC9911@griso.site>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: John Whitmore <arigead@gmail.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On Sat, Jun 14, 2014 at 3:55 AM, John Whitmore <arigead@gmail.com> wrote:
> Was contemplating something which would allow me to transmit CAN Bus frames
> over TCP/IP. Searching throws up a few papers on the subject but wondered if
> there's an OpenSource implementation already out there or any kind of spec on
> the subject. Thought there might be an RFC on the subject but haven't thrown
> up anything.

Take a look at this project: https://github.com/dschanoeh/socketcand

Another variant were to extend slcanpty to accept TCP connections.

Yegor
