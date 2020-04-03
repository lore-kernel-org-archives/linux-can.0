From: Daniels Umanovskis <daniels@umanovskis.se>
Subject: Re: [PATCH] can: tcan4x5x: tcan4x5x_clear_interrupts: remove
 redundant if statement
Date: Fri, 3 Apr 2020 17:05:52 +0200
Message-ID: <cfcf4c61-6f2d-f21e-ffc6-a4acf3ee4883@umanovskis.se>
References: <20200403144602.8494-1-daniels@umanovskis.se>
 <e92799d6-06cf-6b78-0f1b-e85e4710c763@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.weplayciv.com ([162.221.200.53]:50424 "EHLO
        mail.weplayciv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403795AbgDCPF6 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 3 Apr 2020 11:05:58 -0400
In-Reply-To: <e92799d6-06cf-6b78-0f1b-e85e4710c763@ti.com>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Dan Murphy <dmurphy@ti.com>, linux-can@vger.kernel.org

That's more concise and arguably clearer. Sending v2.

On 2020-04-03 16:44, Dan Murphy wrote:
> How about just returning the value of tcan4x5x_write.. and remove the 
> return ret; below
>
> Dan
