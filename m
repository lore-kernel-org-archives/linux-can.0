From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH net-next] can: plx_pci: add support for IXXAT PCI cards
Date: Mon, 12 Dec 2011 12:02:34 +0100
Message-ID: <4EE5DF4A.80301@grandegger.com>
References: <166589D0B9DD2547A1319599B9BADA1FC62431@vsv-exchange.ixxat.intranet.priv>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:37435 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751105Ab1LLLCi (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 12 Dec 2011 06:02:38 -0500
In-Reply-To: <166589D0B9DD2547A1319599B9BADA1FC62431@vsv-exchange.ixxat.intranet.priv>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: kime@ixxat.de
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, socketcan-core@lists.berlios.de

On 12/12/2011 11:44 AM, kime@ixxat.de wrote:
> This patch adds support for IXXAT passive CAN controllers
> 
> Signed-off-by: James Kime <kime@ixxat.de>

I cannot apply this patch. git am reports:

  Applying: can: plx_pci: add support for IXXAT PCI cards
  fatal: corrupt patch at line 30

That's because lines are wrapped, I believe. And could you please update
the Kconfig entry as well?

Thanks,

Wolfgang.
