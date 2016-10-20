From: =?UTF-8?B?S2/FgsWCxIV0YWosIFJlbWlnaXVzeg==?=
        <remigiusz.kollataj@mobica.com>
Subject: Adding new CAN driver
Date: Thu, 20 Oct 2016 11:11:24 +0200
Message-ID: <CAKT-o-cOb0sqRmvH+BKjX4yvBLp5_GqVd6=ifr2jm5T75-hcZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-vk0-f45.google.com ([209.85.213.45]:36312 "EHLO
        mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754463AbcJTJLq (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 20 Oct 2016 05:11:46 -0400
Received: by mail-vk0-f45.google.com with SMTP id 2so63173838vkb.3
        for <linux-can@vger.kernel.org>; Thu, 20 Oct 2016 02:11:46 -0700 (PDT)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hello,

I have created SocketCAN driver for Michrochip CAN BUS Analyzer
(details: https://github.com/rkollataj/mcba_usb). I would like to
upstream it, but as I've never done it before I want to make sure I
will take proper steps.

My understanding is that I should merge my changes with
linux-can-next/master, generate patch and send it to this list. Is
that right?


regards,
Remik
--
