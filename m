From: Jimmy Assarsson <extja@kvaser.com>
Subject: Re: Associate physical device with device name
Date: Thu, 8 Feb 2018 13:05:07 +0100
Message-ID: <33aac663-0a1a-9176-5fa0-cf7c2f84ce53@kvaser.com>
References: <e8998556-5e13-1cec-f404-70c4679ca9c3@kvaser.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-lf0-f45.google.com ([209.85.215.45]:44123 "EHLO
        mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752053AbeBHMFM (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 8 Feb 2018 07:05:12 -0500
Received: by mail-lf0-f45.google.com with SMTP id u20so3858166lff.11
        for <linux-can@vger.kernel.org>; Thu, 08 Feb 2018 04:05:11 -0800 (PST)
In-Reply-To: <e8998556-5e13-1cec-f404-70c4679ca9c3@kvaser.com>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 2018-01-26 15:38, Jimmy Assarsson wrote:
> We would like to be able to associate physical (Kvaser) USB devices with
> their device names (can0 etc.).
> The interface's EAN (article number) combined with serial number, form a
> unique identifier.
> 
> It is not possible to do this from the USB descriptor. Since the serial
> number is not provided in the USB descriptor. And the same PID is reused
> for multiple EAN numbers. It is preferable with a solution that is
> independent of interface type (USB etc.), since we may support other
> devices in the future.
> 
> This is somewhat similar to '"user id" for can usb adapters',
> https://marc.info/?l=linux-can&m=146565019622100
> 
> What is the preferable way of solving this kind of problem? Is sysfs
> suitable?

No suggestions or opinions on this?

Regards,
Jimmy
