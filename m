From: Nikita Edward Baruzdin <nebaruzdin@gmail.com>
Subject: Re: [libsocketcan 2/2] Update can_set_ctrlmode() documentation
Date: Tue, 22 Jul 2014 18:42:38 +0400
Message-ID: <1406040158.13021.1.camel@gmail.com>
References: <1405935800-26622-1-git-send-email-nebaruzdin@gmail.com>
	 <1405935800-26622-5-git-send-email-nebaruzdin@gmail.com>
	 <53CE74A8.3090506@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:49829 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753557AbaGVOmm (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 22 Jul 2014 10:42:42 -0400
Received: by mail-lb0-f178.google.com with SMTP id c11so5165575lbj.23
        for <linux-can@vger.kernel.org>; Tue, 22 Jul 2014 07:42:41 -0700 (PDT)
In-Reply-To: <53CE74A8.3090506@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org

On Tue, 2014-07-22 at 16:26 +0200, Marc Kleine-Budde wrote:
> Have you actually compile-tested this change?
> 
> > libsocketcan.c:781:52: warning: "/*" within comment [-Wcomment]
> >   * #define CAN_CTRLMODE_LOOPBACK           0x01    /* Loopback mode */
> 
> ...and it finally fails to build from source. I've fixed this while
> applying the patch.

By compiling just the docs... Sorry, my fault.


