Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 144FEC433E0
	for <linux-can@archiver.kernel.org>; Mon,  1 Feb 2021 15:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAEDD64D9E
	for <linux-can@archiver.kernel.org>; Mon,  1 Feb 2021 15:21:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbhBAPVS (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Mon, 1 Feb 2021 10:21:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:51230 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231255AbhBAPVM (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 1 Feb 2021 10:21:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 60D4FAB92;
        Mon,  1 Feb 2021 15:20:29 +0000 (UTC)
Date:   Mon, 1 Feb 2021 16:21:32 +0100
From:   Cyril Hrubis <chrubis@suse.cz>
To:     Richard Palethorpe <rpalethorpe@suse.com>
Cc:     ltp@lists.linux.it, Oliver Hartkopp <socketcan@hartkopp.net>,
        linux-can@vger.kernel.org
Subject: Re: [LTP] [PATCH v4 0/7] Convert CAN tests to new LTP API
Message-ID: <YBgcfPG08oqZdh5W@yuki.lan>
References: <20210129170305.27383-1-rpalethorpe@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210129170305.27383-1-rpalethorpe@suse.com>
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi!
Patchset pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
