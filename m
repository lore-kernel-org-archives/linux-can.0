Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27085C4332D
	for <linux-can@archiver.kernel.org>; Tue, 26 Jan 2021 06:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1E6D22B37
	for <linux-can@archiver.kernel.org>; Tue, 26 Jan 2021 06:01:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729577AbhAZGBZ (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Tue, 26 Jan 2021 01:01:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:37042 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729356AbhAYO3n (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 25 Jan 2021 09:29:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CA4E9B9B9;
        Mon, 25 Jan 2021 14:28:54 +0000 (UTC)
Date:   Mon, 25 Jan 2021 15:30:00 +0100
From:   Cyril Hrubis <chrubis@suse.cz>
To:     Richard Palethorpe <rpalethorpe@suse.com>
Cc:     ltp@lists.linux.it, Oliver Hartkopp <socketcan@hartkopp.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can@vger.kernel.org
Subject: Re: [LTP] [PATCH v3 7/7] can: Update contact details
Message-ID: <YA7V6FNZGGma+HiI@yuki.lan>
References: <20210120143723.26483-1-rpalethorpe@suse.com>
 <20210120143723.26483-8-rpalethorpe@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210120143723.26483-8-rpalethorpe@suse.com>
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi!
Minus the runtest files that has to be updated the rest looks ok.

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

Also I do wonder how much of can functionality these tests does not cover.

I guess that we can as well write a test that would add two or more
virtual devices setup routing and send messages between these.

Also there seems to be several different protocols and we seem to be
using only CAN_RAW.

There seems to be also flag to inverse the filter mask with
CAN_INV_FILTER, filter only for error messages and so on.

-- 
Cyril Hrubis
chrubis@suse.cz
