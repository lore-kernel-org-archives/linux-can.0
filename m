Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5AA7C43334
	for <linux-can@archiver.kernel.org>; Tue, 28 Jun 2022 01:35:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243124AbiF1BfW (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Mon, 27 Jun 2022 21:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243084AbiF1BfV (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 27 Jun 2022 21:35:21 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 6DF7B17A9E
        for <linux-can@vger.kernel.org>; Mon, 27 Jun 2022 18:35:20 -0700 (PDT)
Received: (qmail 139257 invoked by uid 1000); 27 Jun 2022 21:35:19 -0400
Date:   Mon, 27 Jun 2022 21:35:19 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Hongren Zenithal Zheng <i@zenithal.me>,
        Rhett Aultman <rhett.aultman@samsara.com>,
        linux-usb@vger.kernel.org, linux-can <linux-can@vger.kernel.org>,
        Oliver Neukum <oneukum@suse.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH v3 1/2] drivers: usb/core/urb: Add URB_FREE_COHERENT
Message-ID: <Yrpa1zpwfauSMoTi@rowland.harvard.edu>
References: <20220609204714.2715188-1-rhett.aultman@samsara.com>
 <20220610213335.3077375-1-rhett.aultman@samsara.com>
 <20220610213335.3077375-2-rhett.aultman@samsara.com>
 <YrSjRvb8rIIayGlg@Sun>
 <143b863d-c86b-6678-44e6-38799391fa36@linuxfoundation.org>
 <YrXNltWSYbplstPx@rowland.harvard.edu>
 <aaf64d6c-1893-67ed-013e-67d21c8be152@linuxfoundation.org>
 <YrX9SBpxp1E2cOyI@rowland.harvard.edu>
 <e1c416bc-0239-6070-c516-c98332a6491d@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1c416bc-0239-6070-c516-c98332a6491d@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Mon, Jun 27, 2022 at 04:54:17PM -0600, Shuah Khan wrote:
> On 6/24/22 12:07 PM, Alan Stern wrote:
> > In the future people will want to make other changes to
> > include/linux/usb.h and they will not be aware that those changes will
> > adversely affect usbip, because there is no documentation saying that
> > the values defined in usb.h are part of a user API.  That will be a
> > problem, because those changes may be serious and important ones, not
> > just decorative or stylistic as in this case.
> > 
> 
> How often do these values change based on our past experience with these
> fields?

I don't know.  You could check the git history to find out for certain.  
My guess would be every eight or ten years.

> > I agree with Hongren that values defined in include/linux/ should not be
> > part of a user API.  There are two choices:
> > 
> 
> I agree with this in general. I don't think this is an explicit decision
> to make them part of API. It is a consequence of simply copying the
> transfer_flags. I am with you both on not being able to recognize the
> impact until as this is rather obscure usage hidden away in the packets.
> These defines aren't directly referenced.
> 
> > 	Move the definitions into include/uapi/linux/, or
> > 
> 
> Wouldn't this be easier way to handle the change? With this option
> the uapi will be well documented.
> 
> > 	Add code to translate the values between the numbers used in
> > 	userspace and the numbers used in the kernel.  (This is what
> > 	was done for urb->transfer_flags in devio.c:proc_do_submiturb()
> > 	near line 1862.)
> > 
> 
> I looked at the code and looks simple enough. I am okay going this route
> if we see issues with the option 1.

It's up to you; either approach is okay with me.  However, I do think 
that the second option is a little better; I don't see any good reason 
why the kernel should be forced to use the same numeric values for these 
flags forever.  Especially since the only user program that needs to 
know them is usbip, which is fairly closely tied to the kernel; if there 
were more programs using those values then they would constitute a good 
reason for choosing the first option.

Alan Stern
