Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2170FC433FE
	for <linux-can@archiver.kernel.org>; Mon, 28 Nov 2022 13:47:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbiK1NrO (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Mon, 28 Nov 2022 08:47:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231979AbiK1NrN (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 28 Nov 2022 08:47:13 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC10F70;
        Mon, 28 Nov 2022 05:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=gtN1aa5N62dsuCrx+e4zS6c4ck0LiKfPXUOc8Hm+0G8=; b=zm6NIBAw5QPZZQhjtusltRxiqK
        TFj3xD/5+XEqJE7tlzPmsG2+DHZvvyDjjS3U1V55TtZJl63aDpLoG/T9WimHNooSkjdltI/o3pFoV
        k7k/+UAxPo0j4mItI7TXX4YyS6JXI6YxkZ0eK0T2sMQ0DOA3AlpFG0qPb466065NdJs8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1ozeTW-003eqN-FY; Mon, 28 Nov 2022 14:47:10 +0100
Date:   Mon, 28 Nov 2022 14:47:10 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        netdev@vger.kernel.org, linux-usb@vger.kernel.org,
        Saeed Mahameed <saeed@kernel.org>,
        Jiri Pirko <jiri@nvidia.com>,
        Lukas Magel <lukas.magel@posteo.net>
Subject: Re: [PATCH v4 3/6] can: etas_es58x: export product information
 through devlink_ops::info_get()
Message-ID: <Y4S73jX07uFAwVQv@lunn.ch>
References: <20221104073659.414147-1-mailhol.vincent@wanadoo.fr>
 <20221126162211.93322-1-mailhol.vincent@wanadoo.fr>
 <20221126162211.93322-4-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221126162211.93322-4-mailhol.vincent@wanadoo.fr>
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

> devlink does not yet have a name suited for the bootloader and so this
> last piece of information is exposed to the userland for through a
> custom name: "bl".

Jiri, what do you think about 'bl'? Is it too short, not well known
enough? It could easily be 'bootloader'.

	Andrew
