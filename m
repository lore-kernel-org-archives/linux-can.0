Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A67C433E0
	for <linux-can@archiver.kernel.org>; Thu,  7 Jan 2021 22:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8655A23602
	for <linux-can@archiver.kernel.org>; Thu,  7 Jan 2021 22:39:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbhAGWje (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Thu, 7 Jan 2021 17:39:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:44292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726410AbhAGWjd (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Thu, 7 Jan 2021 17:39:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B7B42235FA;
        Thu,  7 Jan 2021 22:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610059133;
        bh=yTOabN0xehhgbkZDS+TkrpTf1MVMGIu0wjH5xxB9Sg0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=K3JcbbMb1/oMJI0XvVXHrVQbay5TBrLM9HxiV3wmGR5N1CBPeeABvT6sUyLnjaFDp
         KsX0OZpQBEnMsywIXcV29/h7NwM8jgHytNCdm4ivN42SuaaJ5+yYFyQC4ByhzfSaBK
         aZIzDzuRa5nLZQfm8VLAYIjvg6Kq92clUscSrbIAVAr14tM3Zn8QmzS2zda5QOb/Jr
         mvwgu6XCqhnga8XLj4INXgI1zLPOHCdxrVptExTGg3LOsQqYf89G9PN0KEnMkALwIB
         6apXPBDXH3CL1rfoXVxfa8gbtKlji/PZnxGvnQzs5epi4hTTlMdxgMer4UnkDIwFgL
         i1qbs1vXBTk5w==
Date:   Thu, 7 Jan 2021 14:38:51 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     netdev@vger.kernel.org, davem@davemloft.net,
        linux-can@vger.kernel.org, kernel@pengutronix.de,
        Dan Murphy <dmurphy@ti.com>, Sean Nyekjaer <sean@geanix.com>
Subject: Re: [net-next 15/19] can: tcan4x5x: rework SPI access
Message-ID: <20210107143851.51675f8d@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <c98003bf-e62a-ab6a-a526-1f3ed0bb1ab7@pengutronix.de>
References: <20210107094900.173046-1-mkl@pengutronix.de>
        <20210107094900.173046-16-mkl@pengutronix.de>
        <20210107110035.42a6bb46@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
        <20210107110656.7e49772b@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
        <c98003bf-e62a-ab6a-a526-1f3ed0bb1ab7@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Thu, 7 Jan 2021 22:17:15 +0100 Marc Kleine-Budde wrote:
> > +struct __packed tcan4x5x_buf_cmd { 
> > +	u8 cmd; 
> > +	__be16 addr; 
> > +	u8 len; 
> > +};   
> 
> This has to be packed, as I assume the compiler would add some space after the
> "u8 cmd" to align the __be16 naturally.

Ack, packing this one makes sense.

> > +struct __packed tcan4x5x_map_buf { 
> > +	struct tcan4x5x_buf_cmd cmd; 
> > +	u8 data[256 * sizeof(u32)]; 
> > +} ____cacheline_aligned;   
> 
> Due to the packing of the struct tcan4x5x_buf_cmd it should have a length of 4
> bytes. Without __packed, will the "u8 data" come directly after the cmd?

Yup, u8 with no alignment attribute will follow the previous
field with no holes.
