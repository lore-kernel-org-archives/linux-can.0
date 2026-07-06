Received: from smtpx.fel.cvut.cz (smtpx.feld.cvut.cz [147.32.210.153])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5D32FD681;
	Mon,  6 Jul 2026 10:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=147.32.210.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783335309; cv=none; b=HT1H541i82nENC51gxQmlKi62CYFBgeLcmIQMHIIykLK0kfbddHE3/PKK6PXngYcAjCBxMZQFwtVKiGQumuTXLI4IaOhAMlDGy194gyUP4KL3pfkjwOVkhsmzqB/dWmewCn0Jj1i0EX4t52pFs9Eh7znhD9inmBjp0soEfosxjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783335309; c=relaxed/simple;
	bh=vqq1JkGYxy/RKB08y79WF4x5lCEMFhT9EAXv0WmnMrE=;
	h=From:To:Subject:Date:Cc:References:In-Reply-To:MIME-Version:
	 Content-Type:Content-Disposition:Message-Id; b=Q3pidH4bIzuvtTzwGOZwhsWOemmlYLtug5rYHVvTYLw1unA/5ogA8YdlU/Oc3GyKwT5jDT4mSHoCIG/mnAf/JFOTVZtDPhPqQ8pjM+pIxh/M2zuMPjPsd4iQZbgSAvhQTkk0EwJEDu+Iiv8FWbsTgizuLv8MvkPK6t5XhhVP3lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fel.cvut.cz; spf=pass smtp.mailfrom=fel.cvut.cz; dkim=pass (2048-bit key) header.d=fel.cvut.cz header.i=@fel.cvut.cz header.b=Fuims/1x; arc=none smtp.client-ip=147.32.210.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fel.cvut.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fel.cvut.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fel.cvut.cz header.i=@fel.cvut.cz header.b="Fuims/1x"
Received: from localhost (unknown [192.168.200.27])
	by smtpx.fel.cvut.cz (Postfix) with ESMTP id BDF8F164A3;
	Mon, 06 Jul 2026 12:47:12 +0200 (CEST)
X-Virus-Scanned: IMAP STYX AMAVIS
Received: from smtpx.fel.cvut.cz ([192.168.200.2])
 by localhost (cerokez-250.feld.cvut.cz [192.168.200.27]) (amavis, port 10060)
 with ESMTP id Hvd2cneyefJD; Mon,  6 Jul 2026 12:47:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fel.cvut.cz;
	s=felmail; t=1783334831;
	bh=9/uG2TTrMGnXgpJVhHHlBg8heshLZ+WmDANeUU0A7f8=;
	h=From:To:Subject:Date:Cc:References:In-Reply-To:From;
	b=Fuims/1xskgiS9MlO7zMU4E4GhlRbs0CbYss0jsfIg9/bCKX1/RlhsgeyDQa2SzWk
	 GFZ/Gc9/UhXMWNyokkwvWCV+HYOTKOJQdCcjHTrwnpsToqQUSAZ6jyMWVRh171EWg2
	 ktKmSomFCCcRJdxYidz8bQ01jS2vez06t0HHi8VBdacxsFnI5don++t9/PxcAAXnao
	 3QCOO8PQIsH6yW1qp06zQenLAK+HdPqekpyjrbkS5BGPWzlSbzSrEHwJHps2hH2t+I
	 HNRk6gYw3aqksPb4hZl3xwI/akm1LfDAU4tI/HWcumHxEm4SvJpWNhy3NZ7UgHXhXV
	 w0ej66tgDs3Kg==
Received: from baree.pikron.com (static-84-242-78-234.bb.vodafone.cz [84.242.78.234])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pisa)
	by smtpx.fel.cvut.cz (Postfix) with ESMTPSA id 11D53164A2;
	Mon, 06 Jul 2026 12:47:10 +0200 (CEST)
From: Pavel Pisa <pisa@fel.cvut.cz>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Subject: Re: [PATCH] can: ctucanfd: add missing MODULE_DEVICE_TABLE()
Date: Mon, 6 Jul 2026 12:47:09 +0200
User-Agent: KMail/1.9.10
Cc: Ondrej Ille <ondrej.ille@gmail.com>,
 "Marc Kleine-Budde" <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol@kernel.org>,
 linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260704151957.48194-1-pengpeng@iscas.ac.cn>
In-Reply-To: <20260704151957.48194-1-pengpeng@iscas.ac.cn>
X-KMail-QuotePrefix: > 
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202607061247.09528.pisa@fel.cvut.cz>

Dear Pengpeng Hou,

thanks for catching out omission.

On Saturday 04 of July 2026 17:19:57 Pengpeng Hou wrote:
> The driver has a match table for the pci bus wired into its driver
> structure, but the table is not exported with MODULE_DEVICE_TABLE().
>
> Add the missing MODULE_DEVICE_TABLE() entry so module alias information
> is generated for automatic module loading.
>
> This is a source-level fix.  It does not claim dynamic hardware
> reproduction; the evidence is the driver-owned match table, its use by
> the driver registration structure, and the missing module alias
> publication.
>
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>

Acked-by: Pavel Pisa <pisa@fel.cvut.cz>

> ---
>  drivers/net/can/ctucanfd/ctucanfd_pci.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/net/can/ctucanfd/ctucanfd_pci.c
> b/drivers/net/can/ctucanfd/ctucanfd_pci.c index 7b847b667973..c2b9bce7c2c6
> 100644
> --- a/drivers/net/can/ctucanfd/ctucanfd_pci.c
> +++ b/drivers/net/can/ctucanfd/ctucanfd_pci.c
> @@ -274,6 +274,7 @@ static const struct pci_device_id ctucan_pci_tbl[] = {
>  		CTUCAN_WITH_CTUCAN_ID)},
>  	{},
>  };
> +MODULE_DEVICE_TABLE(pci, ctucan_pci_tbl);
>
>  static struct pci_driver ctucan_pci_driver = {
>  	.name = KBUILD_MODNAME,


                Pavel Pisa
    phone:      +420 603531357
    e-mail:     pisa@cmp.felk.cvut.cz
    Department of Control Engineering FEE CVUT
    Karlovo namesti 13, 121 35, Prague 2
    university: http://control.fel.cvut.cz/
    personal:   http://cmp.felk.cvut.cz/~pisa
    social:     https://social.kernel.org/ppisa
    projects:   https://www.openhub.net/accounts/ppisa
    CAN related:http://canbus.pages.fel.cvut.cz/
    RISC-V education: https://comparch.edu.cvut.cz/
    Open Technologies Research Education and Exchange Services
    https://gitlab.fel.cvut.cz/otrees/org/-/wikis/home
