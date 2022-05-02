Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E2E8C433FE
	for <linux-can@archiver.kernel.org>; Mon,  2 May 2022 23:41:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbiEBXpD (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Mon, 2 May 2022 19:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbiEBXmz (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 2 May 2022 19:42:55 -0400
Received: from mail.enpas.org (zhong.enpas.org [IPv6:2a03:4000:2:537::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7B60E2FFF8;
        Mon,  2 May 2022 16:39:25 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        by mail.enpas.org (Postfix) with ESMTPSA id 209F1FF947;
        Mon,  2 May 2022 23:39:24 +0000 (UTC)
Date:   Tue, 3 May 2022 01:39:19 +0200
From:   Max Staudt <max@enpas.org>
To:     linux-can@vger.kernel.org
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vincent Mailhol <vincent.mailhol@gmail.com>,
        Oliver Neukum <oneukum@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] can, tty: elmcan CAN/ldisc driver for ELM327 based
 OBD-II adapters
Message-ID: <20220503013919.5a918b4f.max@enpas.org>
In-Reply-To: <202205030715.YJrfVKUa-lkp@intel.com>
References: <20220502151222.10681-1-max@enpas.org>
        <202205030715.YJrfVKUa-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Tue, 3 May 2022 07:33:06 +0800
kernel test robot <lkp@intel.com> wrote:

> Hi Max,
> 
> I love your patch! Yet something to improve:
> 
> ...


Thanks, kernel test robot!

I'll head off and fix stuff.


For any reviewers: I'll post a v5 soon.



Max
