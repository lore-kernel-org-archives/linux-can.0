Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F2DC4338F
	for <linux-can@archiver.kernel.org>; Fri,  6 Aug 2021 13:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A41F61158
	for <linux-can@archiver.kernel.org>; Fri,  6 Aug 2021 13:53:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233155AbhHFNxk (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Fri, 6 Aug 2021 09:53:40 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47198 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232548AbhHFNxk (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 6 Aug 2021 09:53:40 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id 148DF1F44A73
Message-ID: <765dc1f100d36b90f424eeccb76ddfa7b5fdb227.camel@collabora.com>
Subject: Re: [PATCH 0/2] D_CAN RX buffer size improvements
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Andrejs Cainikovs <andrejs.cainikovs@gmail.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-can@vger.kernel.org, Dario Binacchi <dariobin@libero.it>,
        fede.a.rossi@gmail.com, msonnaillon@gmail.com
Date:   Fri, 06 Aug 2021 10:53:15 -0300
In-Reply-To: <20210806103639.q3xim42zcispv6ak@pengutronix.de>
References: <20190208132954.28166-1-andrejs.cainikovs@netmodule.com>
         <4da667f3-899a-459c-2cca-6514135a1918@gmail.com>
         <20210806103639.q3xim42zcispv6ak@pengutronix.de>
Organization: Collabora
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

(Adding Federico and Max)

On Fri, 2021-08-06 at 12:36 +0200, Marc Kleine-Budde wrote:
> On 06.08.2021 12:16:26, Andrejs Cainikovs wrote:
> > Sorry for a late reply. I'm the author of this patch set, and I will
> > have a look at this after I obtain the hardware. I hope this is still
> > relevant.
> 
> Dario (Cc'ed) created a proper patch series to support 64 message
> objects. The series has been mainlined in:
> 
> https://git.kernel.org/linus/132f2d45fb2302a582aef617ea766f3fa52a084c
> 

Ah, that's really great news.

Thanks a lot Marc and Dario.
-- 
Kindly,
Ezequiel

