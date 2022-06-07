Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 813BDC43334
	for <linux-can@archiver.kernel.org>; Wed,  8 Jun 2022 00:48:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235519AbiFHAsd (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Tue, 7 Jun 2022 20:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1840875AbiFHAGQ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 7 Jun 2022 20:06:16 -0400
Received: from mail.enpas.org (zhong.enpas.org [46.38.239.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 15A37C0380;
        Tue,  7 Jun 2022 16:55:25 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        by mail.enpas.org (Postfix) with ESMTPSA id BD8D1FFB6C;
        Tue,  7 Jun 2022 23:55:24 +0000 (UTC)
Date:   Wed, 8 Jun 2022 01:55:21 +0200
From:   Max Staudt <max@enpas.org>
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        linux-kernel@vger.kernel.org,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        michael@amarulasolutions.com,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Paolo Abeni <pabeni@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Wolfgang Grandegger <wg@grandegger.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC PATCH 00/13] can: slcan: extend supported features
Message-ID: <20220608015521.1ad4853c.max@enpas.org>
In-Reply-To: <CAMZ6Rq+QpY23bmB4n1DfqaGgxU=i8sKm1Ee9R18xGSv9H5yMVQ@mail.gmail.com>
References: <20220607094752.1029295-1-dario.binacchi@amarulasolutions.com>
        <CAMZ6Rq+QpY23bmB4n1DfqaGgxU=i8sKm1Ee9R18xGSv9H5yMVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Tue, 7 Jun 2022 21:19:54 +0900
Vincent MAILHOL <mailhol.vincent@wanadoo.fr> wrote:

> In his CAN327 driver, Max manages to bring the can0 device without the
> need of dedicated user space daemon by using line discipline
> (ldattach):
> https://lore.kernel.org/linux-can/20220602213544.68273-1-max@enpas.org/
> 
> Isn't the same feasible with slcan so that we completely remove the
> dependency toward slcand?
> Max what do you think of this?

I think it is a good idea to move this into the kernel driver. I don't
have a slcan device, but a quick peek at its protocol suggests that
it can be done much easier and cleaner than in can327.


Fun fact: The use of a userspace "ignition" tool is a possible use case
baked into can327's design ;)

There is only one use case I can see for it though: Probing the
ELM327's baud rate, and/or setting it before attaching the ldisc. This
is the single thing that the kernel driver cannot do, since it is
attached to an already running TTY, with a fixed speed. Everything else
is configurable via "ip link".

slcand could be used to auto-probe and set the baud rate as well.

Then again, these stripped-down tools could likely be implemented as
shell scripts calling stty and ldattach...


Max
