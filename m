From: Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH 0/2] can: m_can_platform: Bug fix of kernel panic for
Date: Thu, 5 Dec 2019 14:57:26 -0600
Message-ID: <f0550b0b-6681-75a3-c58a-28f5b7ca0821@ti.com>
References: <CGME20191119102134epcas5p4d3c1b18203e2001c189b9fa7a0e3aab5@epcas5p4.samsung.com>
 <1574158838-4616-1-git-send-email-pankj.sharma@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1574158838-4616-1-git-send-email-pankj.sharma@samsung.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Pankaj Sharma <pankj.sharma@samsung.com>, linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: wg@grandegger.com, mkl@pengutronix.de, davem@davemloft.net, rcsekar@samsung.com, pankaj.dubey@samsung.com
List-Id: linux-can.vger.kernel.org

Pankaj

On 11/19/19 4:20 AM, Pankaj Sharma wrote:
> The current code is failing while clock prepare enable because of not
> getting proper clock from platform device.
> A device driver for CAN controller hardware registers itself with the
> Linux network layer as a network device. So, the driver data for m_can
> should ideally be of type net_device.
>
> Further even when passing the proper net device in probe function the
> code was hanging because of the function m_can_runtime_resume() getting
> recursively called from m_can_class_resume().
>
> Pankaj Sharma (2):
>    can: m_can_platform: set net_device structure as driver data
>    can: m_can_platform: remove unnecessary m_can_class_resume() call

Did you CC: linux-stable for these?  We are probably going to have 
customers picking up 5.4 LTS and would need these bug fixes.

Or at the very least see if the stable automation will pick these up.

Dan
