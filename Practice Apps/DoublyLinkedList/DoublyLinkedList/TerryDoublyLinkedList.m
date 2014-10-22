//
//  TerryDoublyLinkedList.m
//  DoublyLinkedList
//
//  Created by Aditya Narayan on 10/2/14.
//  Copyright (c) 2014 NM. All rights reserved.
//

#import "TerryDoublyLinkedList.h"

@implementation TerryDoublyLinkedList

- (id) init {
    self = [super init];
    if (self)
    {
        self.length = 0;
        self.head = NULL;
        self.tail = NULL;
    }
    return self;
}


- (void) addObjectAtEnd:(Node *) nodeToAdd {
    
    //no items in the list yet, set this first node as the head of the list
    if (self.head == NULL) {
        self.head = nodeToAdd;
    }
    //if the head is taken, but the tail is NULL, then naturally add the node to tail
    else if (self.head != NULL && self.tail == NULL){
        self.tail = nodeToAdd;
        
        //A (head) becomes the prev of B
        Node *a = self.head;
        a.next = nodeToAdd;
        nodeToAdd.prev = a;
        //B (tail or nodeToAdd) becomes the next of A;
    }
    else {
        //make pointer to retain "initially last element" B
        Node *InitiallylastNodePointer = self.tail;
        //tail gets replaced with the NEW element
        self.tail = nodeToAdd;
        //set "initially last"'s next-property to the NEW element
        InitiallylastNodePointer.next = nodeToAdd;
        //set the prev of the NEW element to the "initially last"
        nodeToAdd.prev = InitiallylastNodePointer;
    }
    self.length++;
    NSLog(@"\n\n New node added to end \n\n");
}


- (void) removeObjectFromHead:(Node *) nodeToDelete {
    
    //pointer to retain the old head and to point to the new head
    Node *pointerToOldHead = self.head;
    Node *pointerToNewHead = self.head.next;
    
    //we need to have the head.next be the new head of the list
    self.head = pointerToNewHead;
    
    //do some cleanup work
    //we need to clear out the New Head's prev property because it was set to OLD head
    self.head.prev = NULL;
    //we also need to lower the list count
    self.length--;
    
    NSLog(@"%@ deleted successfuly \n\n", nodeToDelete);
}

- (void) insertElementBetweenTwoElements:(Node *)insertedElement preElement:(Node *)preElement postElement:(Node *)postElement {
    
    self.length++;
    
    //inserted element's prev is the preElement
    //inserted element's next is the postElement
    insertedElement.prev = preElement;
    insertedElement.next = postElement;
    
    //preElement's next becomes the insertedElement
    preElement.next = insertedElement;
    
    //postElement's prev becomes the inserted Element
    postElement.prev = insertedElement;
    
    NSLog(@"Insert Done successfully");
    
}

- (void) insertElement:(Node *)insertedElement AtIndex:(int)index {

        Node *pointerAtExistingNodeAtThatIndex = self.head;
        //get to that index and make a pointer
        for (int i = 0; i < index; i++) {
            //if it's index 2, we move from head 2 spaces over
            pointerAtExistingNodeAtThatIndex = pointerAtExistingNodeAtThatIndex.next;
        }
        insertedElement.prev = pointerAtExistingNodeAtThatIndex.prev;
        insertedElement.next = pointerAtExistingNodeAtThatIndex;
    
        //the new element becomes the prev for the existingNode
        pointerAtExistingNodeAtThatIndex.prev = insertedElement;
        //the new element becomes the next for the previous node of the existingNode
        Node *prevNode = insertedElement.prev;
        prevNode.next = insertedElement;
        self.length++;
        NSLog(@"Insert Done successfully");
}


- (void) printHeadTailLength {
    NSLog(@"The length of your doubly linked list is %d.", self.length);
    NSLog(@"The head is %@ and head data is %@", self.head, self.head.data);
    NSLog(@"The tail is %@ and tail data is %@", self.tail, self.tail.data);
}

- (void) testPrevsAndNexts {
    //let's test all prev and next values
    int count = 0;
    NSLog(@"The length of your doubly linked list is %d.", self.length);

    NSLog(@"\n\n ****(HEAD) is %@ with data %@", self.head, self.head.data);
    if (self.head.prev != NULL) {
        NSLog(@"Something is wrong because HEAD has a prev property");
    }
    else {
        NSLog(@"HEAD's Prev is %@ because it is the HEAD", self.head.prev);
    }
    NSLog(@"HEAD's next is : %@", self.head.next);
    count++;
    Node *pointerToNextElement = self.head.next;
    while (pointerToNextElement != NULL) {
        NSLog(@"element order#: %d is %@ with data %@", count, pointerToNextElement, pointerToNextElement.data);
        NSLog(@"prev: %@", pointerToNextElement.prev);
        NSLog(@"next: %@", pointerToNextElement.next);
        pointerToNextElement = pointerToNextElement.next;
        count++;
    }
    NSLog(@"\n\n Reached end of List \n\n ");
}


@end
