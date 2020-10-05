Return-Path: <SRS0=JZUr=DM=vger.kernel.org=linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38700C4363A
	for <linux-can@archiver.kernel.org>; Mon,  5 Oct 2020 11:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F36E0206CB
	for <linux-can@archiver.kernel.org>; Mon,  5 Oct 2020 11:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601896433;
	bh=rV6FZ5HcH0jsFcGRFxfWXDBV0w4UyK4mdxTIfWVbAuk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JcxfzcRDvKvcdvv9aMDZx2A3dDu6VrBw55fTlymt0CInrU+qIs496+DWVp6rnjZmN
	 LRCA5xw1Oo0Dz2/HNO7h0JcAp5NhrC+/KSfpZVJNbFXCd1xGiTugLcnzwG5dcQUAFw
	 gxzO3+tSCji18wIQi/2+QJA2mlIb/r0XSareoe+E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbgJELNl (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Mon, 5 Oct 2020 07:13:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:56994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725843AbgJELNl (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 5 Oct 2020 07:13:41 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEAB3206CB;
        Mon,  5 Oct 2020 11:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601896419;
        bh=rV6FZ5HcH0jsFcGRFxfWXDBV0w4UyK4mdxTIfWVbAuk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e3PCs6WDdBiAnytTs+N4EjM6gonnqp6DbF58e5GsDCW9EWXmUxSEbhj7FlYAApAkQ
         3t55bi4HaWLs/NQgL43PPKS9oDiHoxamY7b324sKGbU04EQAio24J75ZBrgXmp6VfZ
         2nbG2H+KeI6RfQL+uTx+jL0QFLgHG/vW0bmayfpw=
Date:   Mon, 5 Oct 2020 13:14:24 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-can@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S . Miller" <davem@davemloft.net>,
        Oliver Neukum <oneukum@suse.com>, linux-usb@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>,
        Arunachalam Santhanam <arunachalam.santhanam@in.bosch.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH v3 7/7] usb: cdc-acm: add quirk to blacklist ETAS ES58X
 devices
Message-ID: <20201005111424.GA361897@kroah.com>
References: <20200926175810.278529-1-mailhol.vincent@wanadoo.fr>
 <20201002154219.4887-1-mailhol.vincent@wanadoo.fr>
 <20201002154219.4887-8-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201002154219.4887-8-mailhol.vincent@wanadoo.fr>
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Sat, Oct 03, 2020 at 12:41:51AM +0900, Vincent Mailhol wrote:
> The ES58X devices has a CDC ACM interface (used for debug
> purpose). During probing, the device is thus recognized as USB Modem
> (CDC ACM), preventing the etas-es58x module to load:
>   usbcore: registered new interface driver etas_es58x
>   usb 1-1.1: new full-speed USB device number 14 using xhci_hcd
>   usb 1-1.1: New USB device found, idVendor=108c, idProduct=0159, bcdDevice= 1.00
>   usb 1-1.1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
>   usb 1-1.1: Product: ES581.4
>   usb 1-1.1: Manufacturer: ETAS GmbH
>   usb 1-1.1: SerialNumber: 2204355
>   cdc_acm 1-1.1:1.0: No union descriptor, testing for castrated device
>   cdc_acm 1-1.1:1.0: ttyACM0: USB ACM device
> 
> Thus, these have been added to the ignore list in
> drivers/usb/class/cdc-acm.c
> 
> N.B. Future firmware release of the ES58X will remove the CDC-ACM
> interface.

I'll queue this up now, as it's needed no matter what the status of the
other patches in this series.

thanks,

greg k-h
