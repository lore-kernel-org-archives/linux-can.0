Return-Path: <linux-can-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB1BC04A6A
	for <linux-can@archiver.kernel.org>; Wed,  2 Aug 2023 13:56:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbjHBN4M (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Wed, 2 Aug 2023 09:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbjHBN4L (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 2 Aug 2023 09:56:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 287462114;
        Wed,  2 Aug 2023 06:56:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B9F49619AB;
        Wed,  2 Aug 2023 13:56:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97436C433C8;
        Wed,  2 Aug 2023 13:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690984569;
        bh=yazmUit565hUeHAtinXm9td8iAqacyHbn0It+r4iReA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WBrNvdlSvI0RZYhXvNe737obQUaTAslGfSsNrj8jlkkBdnfchImM9Ku3gJmK5/M1/
         xsLkffTf5rSWFH5DsaBWJh16L+AAjcgqbukl7rWf+cYoLDWW+ongELmSAhCnEa45hJ
         ZlNaYfc4RmCnrnV0kRMANvaLmv1ka//qxqk6WaJPD8DKRUXUj04BfKvOIruQhyLB7J
         hJt2nqkTvrypasF41m1EjKiGGFNgE6WOfUSczT7nRvxR67qUifvs34L3C6rauRnPIU
         aAJu7WS4A/9LokqKh9Lm0jAPvhzAEqGWdf1bVS10cMnj7Gdgokml005NRuEtqgik1b
         pF+ilz7BINo9w==
Date:   Wed, 2 Aug 2023 15:56:04 +0200
From:   Simon Horman <horms@kernel.org>
To:     Frank Jungclaus <frank.jungclaus@esd.eu>
Cc:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Stefan =?utf-8?B?TcOkdGpl?= <stefan.maetje@esd.eu>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] can: esd_usb: Add support for esd CAN-USB/3
Message-ID: <ZMpgdM4mindkDys0@kernel.org>
References: <20230728150857.2374886-1-frank.jungclaus@esd.eu>
 <20230728150857.2374886-2-frank.jungclaus@esd.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728150857.2374886-2-frank.jungclaus@esd.eu>
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Fri, Jul 28, 2023 at 05:08:57PM +0200, Frank Jungclaus wrote:
> Add support for esd CAN-USB/3 and CAN FD to esd_usb.c.
> 
> Signed-off-by: Frank Jungclaus <frank.jungclaus@esd.eu>

Reviewed-by: Simon Horman <horms@kernel.org>

