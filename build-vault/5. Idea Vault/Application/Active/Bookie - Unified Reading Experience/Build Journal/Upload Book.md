---
draft: true
title: "Upload Book"
date: "2025-02-06"
tags: 
---
Let's try working on the function to upload a book. There are two ways user can upload a book: 
1. Bulk Upload 
2. Upload a Book 
	1. For upload a book we already have a component for that @upload-book-dialog.tsx 

We need to create the same for bulk upload, where essentially it's a dialog aswell, but with a big square that looks like the image above. The idea is that, when user drag and drop, the book will be processed showing to user the preview of that file, and after that create a progress bar of upload. I think it will also be great if we have a toaster on the right side of the app, that shows user their file upload progress just like Dropbox and Google Drive. Let's create the component first, before creating the computations and then the backend.

![[Pasted image 20250206184746.png]]

React dropzone

-----



Great!  
  
For both single upload and bulk upload, let's implement these step by step  
  
1. Implement the actual file upload logic (ensuring we setup the storage bucket, accept only PDF and EPUB, compress file to save space?)  
2. Handle the metadata extraction logic from the files  
3. Add error handling and retry mechanism (also what about background upload, async task?)  
4. Add progress tracking for each file  
5. Create the upload progress toast notifications. 
6. For the wishlist upload, user also can use CSV for the upload.  
  
Also, user should be able to add a book without the actual files, this is a part of the app, where we allow user to also have a wishlist, this wishlist was meant for user to have a collection of books that they plan to read. For an example as you can see in the picture, I have a list of books I want to read, their recommendation, why I want to read it etc, this not yet resulted in my having that book. How can we incorporate this in our app?

But the uploaded book and wishlish should fall under the same "book profile" this to reduce duplication and improve database sharding.  
  
So technically it's the same "shell" but then once user upload a book in that shell, it is not considered as Wishlist anymore.

Also if you check on our @bookprofile there are some metadata that we will display for the book, let's also include that in our book upload metadata.



--------
Yes, the book profile input form can be more compact. The idea and the philosophy is that, user can easily add books they want, this easeness is important cause there are occasions where user might upload more than 100 books in a short time.  
  
Also, as you can see, we want the user to be able to edit the book profile on their own later on. @book-profile-dialog.tsx. The idea is that, once the user input their book (either empty shell for wishlist, or upload a real book), they can manage their reading plan at the library page (through multiple ways of sorting and filtering), they can also add more context through the book profile (recommendation, priority number, tags, etc) to give more score on the prioritization algorithm (we haven't implement this yet). This will then help user to manage their reading better.

