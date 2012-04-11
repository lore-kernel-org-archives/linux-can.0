From: Fabio Baltieri <fabio.baltieri@gmail.com>
Subject: Re: [RFC PATCH] can: add tx/rx led trigger support
Date: Wed, 11 Apr 2012 20:03:21 +0200
Message-ID: <CABkP77dGxmcbPGJ8B9t1HN4nOOjrZLoc63UyQTO+dW7fS2WPKA@mail.gmail.com>
References: <1334093965-2692-1-git-send-email-fabio.baltieri@gmail.com>
	<2082927.TC8ExDXGjY@ws-stein>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:49399 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756753Ab2DKSDW (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 11 Apr 2012 14:03:22 -0400
Received: by wejx9 with SMTP id x9so728180wej.19
        for <linux-can@vger.kernel.org>; Wed, 11 Apr 2012 11:03:21 -0700 (PDT)
In-Reply-To: <2082927.TC8ExDXGjY@ws-stein>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: linux-can@vger.kernel.org

On Wed, Apr 11, 2012 at 8:29 AM, Alexander Stein
<alexander.stein@systec-electronic.com> wrote:
> Am Dienstag, 10. April 2012, 23:39:25 schrieb Fabio Baltieri:
>> This patch adds two led triggers, named <ifname>-tx and <ifname>-rx to
>> each registered canbus interface.
>
> Does this mean, you can have either a tx or rx trigger, bot not both? The
> status LEDs I know from embedded system are triggered by both rx and tx.

That's a point... My idea was to have a tx AND rx trigger - independents.

I also saw adapters with separated tx/rx/error LEDs. Anyway, once the
system is in place, adding a new trigger for a slightly different
behavior - like combined tx/rx - should be easy.

> Despite that, nice idea.

Thanks.

Regards.

-- 
Fabio Baltieri
