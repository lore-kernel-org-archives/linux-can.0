Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B39BC432BE
	for <linux-can@archiver.kernel.org>; Wed, 25 Aug 2021 20:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2820E6103B
	for <linux-can@archiver.kernel.org>; Wed, 25 Aug 2021 20:19:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235663AbhHYUTu (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Wed, 25 Aug 2021 16:19:50 -0400
Received: from lelija.serveriai.lt ([194.135.87.135]:40808 "EHLO
        lelija.serveriai.lt" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234138AbhHYUTu (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 25 Aug 2021 16:19:50 -0400
X-Greylist: delayed 1695 seconds by postgrey-1.27 at vger.kernel.org; Wed, 25 Aug 2021 16:19:50 EDT
Received: from [78.61.95.68] (helo=[192.168.88.188])
        by lelija.serveriai.lt with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <gediminas@rusoku.com>)
        id 1mIyv7-0006Jq-JM; Wed, 25 Aug 2021 22:50:45 +0300
Subject: Re: Renaming can devices interfaces names with udev
To:     Jasper Wallace <jasper@arcolaenergy.com>, linux-can@vger.kernel.org
References: <CAPvzSFeGLtH-fz8mdSZL3UfajeoegvRL6cNuTdru6HnYH2=Hfw@mail.gmail.com>
From:   Gediminas Simanskis <gediminas@rusoku.com>
Message-ID: <f36510b0-e45b-b6e1-b47c-dc6a02e142ad@rusoku.com>
Date:   Wed, 25 Aug 2021 22:50:33 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAPvzSFeGLtH-fz8mdSZL3UfajeoegvRL6cNuTdru6HnYH2=Hfw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-Sender: gediminas@rusoku.com
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi,

I use similar method for net interface name from serial number of Rusoku 
TouCAN converters.It works for me.
https://github.com/rusoku/TouCAN-SocketCAN_DKMS/blob/master/95-toucan.rules

gedsim@PC:~$ ifconfig -a
TouCAN_5211: flags=128<NOARP>  mtu 16
         unspec 00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00 
txqueuelen 10  (UNSPEC)
         RX packets 0  bytes 0 (0.0 B)
         RX errors 0  dropped 0  overruns 0  frame 0
         TX packets 0  bytes 0 (0.0 B)
         TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

Gediminas

On 2021-08-25 21:44, Jasper Wallace wrote:
> Hi all,
>
> I'm going to be using a number of the Korlan/8devices usb2can
> interfaces and I want to make sure they have persistent interface
> names. Thankfully they all have unique serial numbers that are printed
> on the devices so I can match a physical device with a linux interface
> name.
>
> In theory I should be able to do something like add a file at
> /etc/udev/rules.d/10-usb2can.rules containing something like:
>
> SUBSYSTEM=="net", ACTION=="add", ATTR{ID_VENDOR_ENC}=="8Devices",
> ATTR{ID_MODEL}=="USB2CAN_converter", NAME="can$attr{ID_SERIAL_SHORT}"
>
> But I've not been able to get anything to work.
>
> Has anyone been able to get something like this to work?
>
> I'm on Debian Buster.
>
> Thanks,
>
> Jasper
>
