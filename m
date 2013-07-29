From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: Re: slcanpty and TCP
Date: Mon, 29 Jul 2013 11:42:19 +0200
Message-ID: <CAGm1_kvrPje9vvm3zK49Q3ZU126GuNRzZT1SL2vuks8FDBoBLw@mail.gmail.com>
References: <1375090677-4758-1-git-send-email-yegorslists@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-bk0-f47.google.com ([209.85.214.47]:44068 "EHLO
	mail-bk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750898Ab3G2Jml (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 29 Jul 2013 05:42:41 -0400
Received: by mail-bk0-f47.google.com with SMTP id jg9so444078bkc.20
        for <linux-can@vger.kernel.org>; Mon, 29 Jul 2013 02:42:39 -0700 (PDT)
In-Reply-To: <1375090677-4758-1-git-send-email-yegorslists@googlemail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Oliver Hartkopp <socketcan@hartkopp.net>

On Mon, Jul 29, 2013 at 11:37 AM,  <yegorslists@googlemail.com> wrote:
> This is a first quick and dirty patch for including TCP support.
> There some questions to clear. The firs one is, what to do with ENOBUFS
> (http://dics.voicecontrol.ro/process_mails/arata_discutia/173374/[PATCH]_candump:_add_option_to_ignore_ENOBUFS.html)?
>
> What about providing LAN interface name or none for expicit binding?

Another question. How to tell pty from network settings? I'd suggest,
that user must always provide an absolute path to pty device, so
checking for '/' should be sufficient.

For network stuff we could specify following: [interface name] :port
and if without [interface name], then bind to ANY.

Yegor
