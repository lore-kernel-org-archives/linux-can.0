From: Jimmy Assarsson <extja@kvaser.com>
Subject: Associate physical device with device name
Date: Fri, 26 Jan 2018 15:38:00 +0100
Message-ID: <e8998556-5e13-1cec-f404-70c4679ca9c3@kvaser.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-lf0-f48.google.com ([209.85.215.48]:44928 "EHLO
        mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752393AbeAZOiD (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 26 Jan 2018 09:38:03 -0500
Received: by mail-lf0-f48.google.com with SMTP id v188so930188lfa.11
        for <linux-can@vger.kernel.org>; Fri, 26 Jan 2018 06:38:02 -0800 (PST)
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi,

We would like to be able to associate physical (Kvaser) USB devices with
their device names (can0 etc.).
The interface's EAN (article number) combined with serial number, form a
unique identifier.

It is not possible to do this from the USB descriptor. Since the serial
number is not provided in the USB descriptor. And the same PID is reused
for multiple EAN numbers. It is preferable with a solution that is
independent of interface type (USB etc.), since we may support other
devices in the future.

This is somewhat similar to '"user id" for can usb adapters',
https://marc.info/?l=linux-can&m=146565019622100

What is the preferable way of solving this kind of problem? Is sysfs
suitable?


Regards,
Jimmy
