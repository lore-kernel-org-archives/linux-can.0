Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5769C433FE
	for <linux-can@archiver.kernel.org>; Sun,  6 Nov 2022 00:45:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbiKFApN (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Sat, 5 Nov 2022 20:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiKFApN (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 5 Nov 2022 20:45:13 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id EB6EE11456
        for <linux-can@vger.kernel.org>; Sat,  5 Nov 2022 17:45:11 -0700 (PDT)
Received: (qmail 394112 invoked by uid 1000); 5 Nov 2022 20:45:10 -0400
Date:   Sat, 5 Nov 2022 20:45:10 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 3/3] can: etas_es58x: report the firmware version
 through ethtool
Message-ID: <Y2cDlrNjL5YSAPm2@rowland.harvard.edu>
References: <20221104073659.414147-1-mailhol.vincent@wanadoo.fr>
 <20221104171604.24052-1-mailhol.vincent@wanadoo.fr>
 <20221104171604.24052-4-mailhol.vincent@wanadoo.fr>
 <Y2Ydf6UxVvTe8Zmz@kroah.com>
 <CAMZ6RqJkzag-PGuzHcDQkSXjqH6d8=uAe-UN8VXUoNWX2x+qbw@mail.gmail.com>
 <CAMZ6RqLMGfW0QcNdBKhfwayV=+FNHhvM_-ob0UvL=o6=zN0J7A@mail.gmail.com>
 <Y2afm9xFIvJnwXh/@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2afm9xFIvJnwXh/@kroah.com>
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Sat, Nov 05, 2022 at 06:38:35PM +0100, Greg Kroah-Hartman wrote:
> On Sun, Nov 06, 2022 at 02:21:11AM +0900, Vincent MAILHOL wrote:
> > On Sat. 5 Nov. 2022 at 18:27, Vincent MAILHOL
> > <mailhol.vincent@wanadoo.fr> wrote:
> > > On Sat. 5 Nov. 2022 at 17:36, Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> It's late right now, and I can't remember the whole USB spec, but I
> think the device provides a list of the string ids that are valid for
> it.  If so, we can add that to sysfs for any USB device out there, no
> matter the string descriptor number.

No, there is no such list.

> If not, maybe we can just iterate the 255 values and populate sysfs
> files if they are present?  I'll dig up the USB spec tomorrow...

Yes, we could do that.  But the filename would have to be the string 
id, which is not meaningful.  We wouldn't be able to have labels like 
"product-info" unless somehow a driver could provide the label.

Also, there's the matter of language.  Devices can have string 
descriptors in multiple languages; which one should we show in sysfs?  
All of them?  Right now we use just the default language for the strings 
that we put in sysfs.

> I say do this at the USB core level, that way it works for any USB
> device, and you don't have a device-specific sysfs file and custom
> userspace code just for this.

This is unavoidable to some extent.  Without device-specific information 
or userspace code, there is no way to know which string descriptor 
contains the data you want.

Alan Stern

> Sound reasonable?
> 
> greg k-h
