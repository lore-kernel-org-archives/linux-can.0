From: Wolfram Sang <wsa@sang-engineering.com>
Subject: Re: [patch] can: c_can: checking IS_ERR() instead of NULL
Date: Fri, 01 Aug 2014 20:16:20 +0200
Message-ID: <53DBD974.3000307@sang-engineering.com>
References: <20140801085344.GA31702@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:37644 "EHLO mail.zeus03.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750851AbaHASQ2 (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 1 Aug 2014 14:16:28 -0400
In-Reply-To: <20140801085344.GA31702@mwanda>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Dan Carpenter <dan.carpenter@oracle.com>, Wolfgang Grandegger <wg@grandegger.com>, George Cherian <george.cherian@ti.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, Thor Thayer <tthayer@altera.com>, Pavel Machek <pavel@denx.de>, Mugunthan V N <mugunthanvnm@ti.com>, "Lad, Prabhakar" <prabhakar.csengg@gmail.com>, linux-can@vger.kernel.org, kernel-janitors@vger.kernel.org

> Fixes: 33cf75656923 ('can: c_can_platform: Fix raminit, use devm_ioremap() instead of devm_ioremap_resource()')

Reverting this patch is the correct solution. Its approach is totally 
bogus anyhow.


