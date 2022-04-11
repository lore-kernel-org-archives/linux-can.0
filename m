Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3201BC433EF
	for <linux-can@archiver.kernel.org>; Mon, 11 Apr 2022 14:44:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347406AbiDKOqt (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Mon, 11 Apr 2022 10:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347423AbiDKOqp (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 11 Apr 2022 10:46:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808496308;
        Mon, 11 Apr 2022 07:44:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 317A1B81642;
        Mon, 11 Apr 2022 14:44:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5956AC385AA;
        Mon, 11 Apr 2022 14:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649688266;
        bh=wRS32LY4IFKjyMTbt6v9mzrbqkRbajAdkzIV2R16PWI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Git/6+GZ1V+us/4zFLZ8fdANLsQlRITLyulLhrvINrV5LqR2AaZI/UyjGhEzcJcry
         wACKmHj0qZjsxKV/Pk/Lt9b+AHGhdQHk6VXYnQCpJfB4Pk/Gty8ysaf2om4QHTJ9cu
         dTxIJ+O2gZefNQqfLiPSqm0BU0tVgldjywiluSceU45zhKCzY7PhoLuKAxy1xmK0Tw
         t5g7DJcLIjmL1N/NF82Des30DIrSuEcDvhfDIBHxYz8q8rqjaop8WVeasUx/08EW/C
         fKmHZjztkkuMtcNy00AA858gAJDyRS+YuquxgI+N3cb5EbNfpfxQu5msnHE4JV1BGx
         xTh9demcCpirQ==
Date:   Mon, 11 Apr 2022 20:14:23 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-can@vger.kernel.org
Subject: Re: [PATCH v5] phy: phy-can-transceiver: Add support for setting mux
Message-ID: <YlQ+x555++i4Vmlx@matsya>
References: <20220408111316.21189-1-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220408111316.21189-1-a-govindraju@ti.com>
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 08-04-22, 16:43, Aswath Govindraju wrote:
> On some boards, for routing CAN signals from controller to transceiver,
> muxes might need to be set. Therefore, add support for setting the mux by
> reading the mux-states property from the device tree node.

Applied, thanks

-- 
~Vinod
