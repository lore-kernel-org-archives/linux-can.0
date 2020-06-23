From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v41 0/3] can: add mcp25xxfd support
Date: Tue, 23 Jun 2020 14:49:48 +0200
Message-ID: <31b3b729-021f-b24c-ecdf-ad80659a3990@pengutronix.de>
References: <20200622114603.965371-1-mkl@pengutronix.de>
 <20200623124649.GC13669@Mani-XPS-13-9360>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732540AbgFWMtz (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 23 Jun 2020 08:49:55 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9EDC061573
        for <linux-can@vger.kernel.org>; Tue, 23 Jun 2020 05:49:54 -0700 (PDT)
In-Reply-To: <20200623124649.GC13669@Mani-XPS-13-9360>
Content-Language: de-DE
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: linux-can@vger.kernel.org, dev.kurt@vandijck-laurijssen.be

On 6/23/20 2:46 PM, Manivannan Sadhasivam wrote:
> On Mon, Jun 22, 2020 at 01:46:00PM +0200, Marc Kleine-Budde wrote:
>> Hello,
>>
>> this series adds support for the Microchip MCP25xxFD SPI CAN controller family.
>>
>> The series is available at:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git/log/?h=mcp25xxfd-41
>>
> 
> Tested this series on an SM8250 based board connected to MCP2518FD over SPI.
> Hence,
> 
> Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

tnx.

Marc

-- 
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |
