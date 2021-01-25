Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C6CC43381
	for <linux-can@archiver.kernel.org>; Tue, 26 Jan 2021 06:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D115D22AAC
	for <linux-can@archiver.kernel.org>; Tue, 26 Jan 2021 06:01:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728580AbhAZGBZ (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Tue, 26 Jan 2021 01:01:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:36274 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729510AbhAYO3n (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 25 Jan 2021 09:29:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 57285AD24;
        Mon, 25 Jan 2021 14:28:29 +0000 (UTC)
Date:   Mon, 25 Jan 2021 15:29:35 +0100
From:   Cyril Hrubis <chrubis@suse.cz>
To:     Richard Palethorpe <rpalethorpe@suse.com>
Cc:     ltp@lists.linux.it, Oliver Hartkopp <socketcan@hartkopp.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can@vger.kernel.org
Subject: Re: [LTP] [PATCH v3 5/7] can_recv_own_msgs: Convert to new library
Message-ID: <YA7Vz6IanQ7fMgEQ@yuki.lan>
References: <20210120143723.26483-1-rpalethorpe@suse.com>
 <20210120143723.26483-6-rpalethorpe@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210120143723.26483-6-rpalethorpe@suse.com>
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi!
> -struct rxs test_sockets(int s, int t, canid_t can_id)
> +void test_sockets(canid_t can_id, int expect_rxs, int expect_rxt)

static?

However this is very minor.

-- 
Cyril Hrubis
chrubis@suse.cz
