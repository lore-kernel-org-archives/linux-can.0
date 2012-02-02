From: Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
Subject: Re: CAN Data Transfer not happening at 1Mbps
Date: Thu, 02 Feb 2012 15:50:28 +0100
Message-ID: <4F2AA2B4.2090906@grandegger.com>
References: <4ED62A07621E9C41B8CB2F608655EF45053759D1@POCITMSEXMB02.LntUniverse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <socketcan-users-bounces-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org>
In-Reply-To: <4ED62A07621E9C41B8CB2F608655EF45053759D1-7aE7LFdIys/Tuj3VkTsHpK9mtlLuIFWGZeezCHUQhQ4@public.gmane.org>
List-Unsubscribe: <https://lists.berlios.de/mailman/options/socketcan-users>,
	<mailto:socketcan-users-request-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.berlios.de/pipermail/socketcan-users>
List-Post: <mailto:socketcan-users-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org>
List-Help: <mailto:socketcan-users-request-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org?subject=help>
List-Subscribe: <https://lists.berlios.de/mailman/listinfo/socketcan-users>,
	<mailto:socketcan-users-request-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org?subject=subscribe>
Sender: socketcan-users-bounces-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org
Errors-To: socketcan-users-bounces-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org
To: Nikhil Kamath <Nikhil.Kamath-jt7Hd8rR/UrQT0dZR+AlfA@public.gmane.org>
Cc: "socketcan-users-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org" <socketcan-users-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org>, Linux-CAN <linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-can.vger.kernel.org

On 02/02/2012 03:24 PM, Nikhil Kamath wrote:
> Hi,
> I am having a i.Mx35 PDK board   running linux-2.6.35 kernel. CAN communication is done using the socket CAN driver  taken from the mainline kernel.

This means you are not using a mainline kernel, right? Are you using
Freescale's ltib linux-2.6.35 tree?

> Issue - Data transfer not happening at 1Mbps bitrate  , works fine on other bitrates.
> 
> Please help in resolving the issue.

- From what kernel version is the Flexcan driver derived?
- What does "dmesg" report when you load the driver?
- What does "ip -d -s link show can0" report after an unsuccessful
  transfer?
- What does "candump -e any,0:0,#FFFFFFFF" report while sending
  messages?

Wolfgang.

PS:

please do not use this mailing list any longer but send your questions
to the new "linux-can" mailing list address "linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org".
For subscription or mailing list archives please have a look to:

   http://vger.kernel.org/vger-lists.html#linux-can

Mail archives of the new linux-can mailing list can be found at:

   http://dir.gmane.org/gmane.linux.can
   http://marc.info/?l=linux-can&r=1&w=2
