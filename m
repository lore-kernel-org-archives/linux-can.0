From: Martin Gysel <m.gysel@gmail.com>
Subject: Re: [Socketcan-users] [socketcan]problem to using CAN with BeagleBone
 Black A5A
Date: Tue, 04 Jun 2013 13:23:19 +0200
Message-ID: <51ADCE27.6010600@gmail.com>
References: <CABMxt4gM55=Og5GdYmK_KHLuH1oQexGhcSpXRP3CA3FywjT5Yg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:48420 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751085Ab3FDLXe (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 4 Jun 2013 07:23:34 -0400
Received: by mail-wi0-f174.google.com with SMTP id c10so3604391wiw.1
        for <linux-can@vger.kernel.org>; Tue, 04 Jun 2013 04:23:33 -0700 (PDT)
In-Reply-To: <CABMxt4gM55=Og5GdYmK_KHLuH1oQexGhcSpXRP3CA3FywjT5Yg@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: socketcan-users@lists.berlios.de

Am 25.05.2013 00:49, schrieb Mohamed HAMZAOUI:
> Hi,
> 
> I started with beaglebone black A5A, i installed on it the latest
> Angstrom image with : Linux beaglebone 3.8.13 #1 SMP Mon May 20
> 17:07:58 CEST 2013 armv7l GNU/Linux
> 
> I have a problem when I try to add a can device, i load with modprobe
> all necessary kernel module (can, ti_hecc, c_can, c_can_platform,
> can-raw, can-bcm) but when i execute
>> ip link add can0 type can
> I have : RTNETLINK answers: Operation not supported
> I used a recent version of iproute2.

did you initialize the can module? do you use a can cape? if yes, does
your kernel already include the needed dts to enable the can module?

/martin

