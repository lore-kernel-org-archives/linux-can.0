From: Mohamed HAMZAOUI <requinham@gmail.com>
Subject: problem to using CAN on beaglebone black A5A
Date: Sat, 25 May 2013 00:56:29 +0200
Message-ID: <CABMxt4idBKa8tH4b4T4Z5AQir3UOOjvR1ocTv3OAN6Aqqtccpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-la0-f50.google.com ([209.85.215.50]:44292 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755204Ab3EXW4b (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 24 May 2013 18:56:31 -0400
Received: by mail-la0-f50.google.com with SMTP id ed20so5016482lab.9
        for <linux-can@vger.kernel.org>; Fri, 24 May 2013 15:56:29 -0700 (PDT)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can Mailing List <linux-can@vger.kernel.org>

Hi,

I started with beaglebone black A5A, i installed on it the latest
Angstrom image with : Linux beaglebone 3.8.13 #1 SMP Mon May 20
17:07:58 CEST 2013 armv7l GNU/Linux

I have a problem when I try to add a can device, i load with modprobe
all necessary kernel module (can, ti_hecc, c_can, c_can_platform,
can-raw, can-bcm) but when i execute
> ip link add can0 type can
I have : RTNETLINK answers: Operation not supported
I used a recent version of iproute2.

Can anyone help me please ?

Regards,
Mohamed
