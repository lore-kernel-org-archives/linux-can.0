Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A4EC433EF
	for <linux-can@archiver.kernel.org>; Tue,  5 Jul 2022 09:59:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbiGEJ7N (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Tue, 5 Jul 2022 05:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbiGEJ5R (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 5 Jul 2022 05:57:17 -0400
Received: from mail.enpas.org (zhong.enpas.org [IPv6:2a03:4000:2:537::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DCA7CB7F9;
        Tue,  5 Jul 2022 02:56:19 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        by mail.enpas.org (Postfix) with ESMTPSA id 247EEFF9BF;
        Tue,  5 Jul 2022 09:56:16 +0000 (UTC)
Date:   Tue, 5 Jul 2022 11:56:13 +0200
From:   Max Staudt <max@enpas.org>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org,
        Vincent Mailhol <vincent.mailhol@gmail.com>,
        Oliver Neukum <oneukum@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v9] can, tty: can327 CAN/ldisc driver for ELM327 based
 OBD-II adapters
Message-ID: <20220705115613.69d32b22.max@enpas.org>
In-Reply-To: <20220705094927.vgtxcjh4klw6dcg3@pengutronix.de>
References: <20220618195031.10975-1-max@enpas.org>
        <20220627150557.qluqtejrddj5nfif@pengutronix.de>
        <20220627190126.4eb57a2b.max@enpas.org>
        <CAMuHMdUYCiRC+9UnQB6-2XGp+wOjYq1U_J3bDQT+WNm==mS4qg@mail.gmail.com>
        <20220705094927.vgtxcjh4klw6dcg3@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Tue, 5 Jul 2022 11:49:27 +0200
Marc Kleine-Budde <mkl@pengutronix.de> wrote:

> On 05.07.2022 11:43:52, Geert Uytterhoeven wrote:
> > So development started before commit cd6484e1830be260 ("serdev:
> > Introduce new bus for serial attached devices").  I guess that is
> > the reason why this driver uses a line discipline, instead of the
> > serial bus?
> > 
> > I had a quick glance through the various revisions posted, and it
> > doesn't seem like anyone mentioned the serial bus.  Would there be
> > any advantage in migrating to the serial bus?  
> 
> Does serial bus work with hot plug devices like USB Serial Adapters
> and/or devices that are not described in the device tree?

This is indeed the reason. The device cannot be autodetected, as the
UART has no identifying information (USB VID/PID or the like, and don't
forget the BT variants) attached to it, hence the manual attachment.


Max
