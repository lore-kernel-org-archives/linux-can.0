Return-Path: <linux-can-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A182C64EC7
	for <linux-can@archiver.kernel.org>; Tue, 28 Feb 2023 20:59:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjB1U7K convert rfc822-to-8bit (ORCPT
        <rfc822;linux-can@archiver.kernel.org>);
        Tue, 28 Feb 2023 15:59:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjB1U7J (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 28 Feb 2023 15:59:09 -0500
X-Greylist: delayed 576 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 28 Feb 2023 12:59:07 PST
Received: from smtpx.fel.cvut.cz (smtpx.feld.cvut.cz [147.32.210.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8700AA24E
        for <linux-can@vger.kernel.org>; Tue, 28 Feb 2023 12:59:07 -0800 (PST)
Received: from localhost (styx2022 [192.168.200.17])
        by smtpx.fel.cvut.cz (Postfix) with ESMTP id 7B3B13BDA7;
        Tue, 28 Feb 2023 21:49:29 +0100 (CET)
X-Virus-Scanned: IMAP STYX AMAVIS
Received: from smtpx.fel.cvut.cz ([192.168.200.2])
        by localhost (styx2.feld.cvut.cz [192.168.200.17]) (amavisd-new, port 10060)
        with ESMTP id JPyBSbYdKayc; Tue, 28 Feb 2023 21:49:27 +0100 (CET)
Received: from steelpick.2x.cz (ip-94-112-196-33.bb.vodafone.cz [94.112.196.33])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sojkam1)
        by smtpx.fel.cvut.cz (Postfix) with ESMTPSA id 7339A3BE99;
        Tue, 28 Feb 2023 21:49:27 +0100 (CET)
Received: (nullmailer pid 322816 invoked by uid 1000);
        Tue, 28 Feb 2023 20:49:26 -0000
From:   Michal Sojka <michal.sojka@cvut.cz>
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     linux-can <linux-can@vger.kernel.org>
Subject: Re: please re-send [RFC PATCH] can: isotp: fix poll() to not report
 false positive EPOLLOUT events
In-Reply-To: <b53a04a2-ba1f-3858-84c1-d3eb3301ae15@hartkopp.net>
References: <b53a04a2-ba1f-3858-84c1-d3eb3301ae15@hartkopp.net>
Date:   Tue, 28 Feb 2023 21:49:26 +0100
Message-ID: <878rghtt0p.fsf@steelpick.2x.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Oliver,

On Tue, Feb 28 2023, Oliver Hartkopp wrote:
> Hi Michal,
>
> I'm currently testing some isotp traffic with your 'poll' patch but 
> unfortunately I did not see this mail in my in-box:
>
> https://lore.kernel.org/linux-can/20230224010659.48420-1-michal.sojka@cvut.cz/T/#u
>
> It is visible on the mail archive but obviously something went wrong on 
> my mail server side ¯\_(ツ)_/¯
>
> Can you please re-send your patch, so that I can comment inside?

resending in a minute.

-Michal
