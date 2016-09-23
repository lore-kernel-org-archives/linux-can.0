From: =?UTF-8?Q?Andr=c3=a9_Hartmann?= <aha_1980@gmx.de>
Subject: Re: libsocketcan proposal for upstream (get typekind vcan or can,
 etc.)
Date: Fri, 23 Sep 2016 14:15:42 +0200
Message-ID: <7aa949c7-a99b-7446-963c-00be0ad98318@gmx.de>
References: <CAPgtGZNhuinRb-gpj9QkTVnhfY8PE03JKoqhKm8Lw3g2s1+rzw@mail.gmail.com>
 <CAPgtGZOuJEkRC+X4yWz8E4Qp1SZivkj6RV9kZ3RPJ20MUBAfUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.18]:52702 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965042AbcIWMPx (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Fri, 23 Sep 2016 08:15:53 -0400
In-Reply-To: <CAPgtGZOuJEkRC+X4yWz8E4Qp1SZivkj6RV9kZ3RPJ20MUBAfUA@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: aj neu <ajneu1@gmail.com>, linux-can@vger.kernel.org

Hi again AJ,

I've now taken a second look at your patch.

As all functions in libsocketcan start with can_*, your new functions 
device_exists and device_is_up are not consistent. As all existing 
functions already have const char *name as first parameter, I think the 
word "device" is superflous. Having all functions starting with can_* 
helps including the library in existing projects.

Suggestions:

int can_is_(existing|available|present)(const char *name);
int can_is_up(const char *name);

Best regards,
André

Am 23.09.2016 um 08:19 schrieb aj neu:
> On Fri, Sep 23, 2016 at 8:16 AM, aj neu wrote:
>> Hello,
>>
>> below, please find a patch which adds the following functions to libsocketcan
>>
>>     device_exists, device_is_up, can_get_typekind
>>
>>     int device_exists(const char *name);
>>      // determine if device is libsocketcan-compatible and exists
>>
>>     int device_is_up(const char *name);
>>      // determine if device is up (also usable for vcan)
>>
>>     int can_get_typekind(const char *name, char *buf, size_t buflen);
>>      // determine if typekind is "can" or "vcan"
>>
>>
>> The patch can be applied to
>> https://git.platon.pengutronix.de/cgit/tools/libsocketcan
>> as follows:
>>    git apply diff.patch
>>
>>
>> Can this be applied to upstream?
>>
>> Thanks.
>> ajneu
>
> Here's the patch as attachment.
>

