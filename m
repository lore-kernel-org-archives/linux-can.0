From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: [PATCH 0/6] Add Microchip MCP25XXFD CAN driver
Date: Mon, 22 Jun 2020 14:30:31 +0200
Message-ID: <20200622123031.GB3077@x1.vandijck-laurijssen.be>
References: <20200610074442.10808-1-manivannan.sadhasivam@linaro.org>
 <fbbca009-3c53-6aa9-94ed-7e9e337c31a4@pengutronix.de>
 <20200617165902.GB14228@x1.vandijck-laurijssen.be>
 <2e80e2ed-d63d-5cc6-e1c6-e0c9e75c218e@pengutronix.de>
 <20200618123055.GA17496@x1.vandijck-laurijssen.be>
 <c8267280-e7a9-8171-d714-fa392ccb5537@pengutronix.de>
 <20200622102559.GA3077@x1.vandijck-laurijssen.be>
 <c5fc46c1-abaf-cf67-abb6-0077bafdff3a@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay-b01.edpnet.be ([212.71.1.221]:33152 "EHLO
        relay-b01.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728080AbgFVMat (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 22 Jun 2020 08:30:49 -0400
Content-Disposition: inline
In-Reply-To: <c5fc46c1-abaf-cf67-abb6-0077bafdff3a@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, wg@grandegger.com, kernel@martin.sperl.org, linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

On ma, 22 jun 2020 12:55:41 +0200, Marc Kleine-Budde wrote:
> Date:   Mon, 22 Jun 2020 12:55:41 +0200
> From: Marc Kleine-Budde <mkl@pengutronix.de>
> To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
>  wg@grandegger.com, kernel@martin.sperl.org, linux-can@vger.kernel.org,
>  netdev@vger.kernel.org, linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 0/6] Add Microchip MCP25XXFD CAN driver
> User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
>  Thunderbird/68.9.0
> 
> On 6/22/20 12:25 PM, Kurt Van Dijck wrote:
> > I got my board up with a 5.7, despite device-tree problems completely
> > unrelated to CAN.
> 
> \o/
> 
> > It seems to work well with a fully-loaded CAN bus (cangen -g0 ...).
> > So that is a real improvement.
> 
> Can I add your Tested-by?
yes.
> 
> > I will need to add the listen-only mode soon.
> 
> Patches are always welcome!
> 
> regards,
> Marc
> 
> -- 
> Pengutronix e.K.                 | Marc Kleine-Budde           |
> Embedded Linux                   | https://www.pengutronix.de  |
> Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |
